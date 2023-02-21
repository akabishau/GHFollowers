//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/19/23.
//

import UIKit

class FollowerListVC: UIViewController {
	
	var username: String!
	
	init(username: String) {
		super.init(nibName: nil, bundle: nil)
		self.username = username
		title = username
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	// Pagination Logic
	var followers: [Follower] = []
	var page = 1
	var hasMoreFollowers = true // flip to false when api returns less than 100 records
	
	
	// enums are hashable by default
	enum Section {
		case main
	}
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
		
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		configureCollectionView()
		configureDataSource()
		getFollowers(username: username, page: page)
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	
	private func getFollowers(username: String, page: Int) {
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			
			guard let self = self else { return }
			
			switch result {
				case .success(let followers):
					if followers.count < 100 { self.hasMoreFollowers = false }
					self.followers.append(contentsOf: followers)
					print(self.followers.count)
					self.updateData(on: self.followers)
				case .failure(let error):
					print("failed: \(error.rawValue)")
					self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
					DispatchQueue.main.async {
						self.navigationController?.popViewController(animated: true)
					}
			}
		}
	}
	
	
	private func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view))
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
		collectionView.delegate = self
		
	}
	
	
	// after calling this function collection view doesn't know about [follower]
	private func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
			cell.set(follower: itemIdentifier)
			return cell
		})
	}
	
	
	private func updateData(on followers: [Follower]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}
}



//MARK: - Scroll and Collection View Delegate
extension FollowerListVC: UICollectionViewDelegate {
	
	// less calls than for scrollViewDidScroll
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		
		if UIHelper.didUserScrollToEnd(of: scrollView) {
			guard hasMoreFollowers else { return }
			page += 1
			getFollowers(username: username, page: page)
		}
	}
}
