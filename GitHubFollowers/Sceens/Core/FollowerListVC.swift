//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/19/23.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
	
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
	var isLoadingFollowers = false // controls avoiding racing conditions when multiple network calls triggered by user scrolling though the list of followers
	
	var isSearching = false
	var filteredFollowers: [Follower] = []
	
	
	// enums are hashable by default
	enum Section {
		case main
	}
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
		
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureViewController()
		configureSearchController()
		configureCollectionView()
		configureDataSource()
		getFollowers(username: username, page: page)
	}
	
	
	private func configureViewController() {
		navigationController?.setNavigationBarHidden(false, animated: true)
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
		navigationItem.rightBarButtonItem = addButton
	}
	
	
	@objc private func addButtonTapped() {
		print(#function)
	}
	
	
	private func getFollowers(username: String, page: Int) {
		
		showLoadingView()
		isLoadingFollowers = true
		
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			
			guard let self = self else { return }
			self.dismissLoadingView()
			switch result {
				case .success(let followers):
					if followers.count < 100 { self.hasMoreFollowers = false }
					self.followers.append(contentsOf: followers)
					
					if self.followers.isEmpty {
						let message = "This user doesn't have any followers. Go follow them 😀."
						DispatchQueue.main.async {
							print("here")
							self.showEmptyStateView(with: message, in: self.view)
						}
					}
					
					self.updateData(on: self.followers)
				case .failure(let error):
					print("failed: \(error.rawValue)")
					self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
					DispatchQueue.main.async {
						self.navigationController?.popViewController(animated: true)
					}
			}
		}
		
		isLoadingFollowers = false
	}
	
	
	//MARK: - Collection View
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
		
		// can be called from background but in this case calling from main for consistency
		DispatchQueue.main.async {
			self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
		}
	}
}

//MARK: - Search Controller
extension FollowerListVC: UISearchResultsUpdating {
	
	//TODO: - is it okay to put it here?
	private func configureSearchController() {
		let searchController = UISearchController()
		searchController.searchResultsUpdater = self // delegate
		searchController.searchBar.placeholder = "Search for a username"
		searchController.obscuresBackgroundDuringPresentation = false // removes default faint black overlay
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		
	}
	
	// called when cancel button clicked, so no need in delegate method
	func updateSearchResults(for searchController: UISearchController) {
		
		guard let filter = searchController.searchBar.text, !filter.isEmpty else {
			filteredFollowers.removeAll()
			updateData(on: followers)
			isSearching = false
			return
		}
		
		isSearching = true
		filteredFollowers = followers.filter({ follower in
			follower.login.lowercased().contains(filter.lowercased())
		})
		updateData(on: filteredFollowers)
	}
}



//MARK: - Scroll and Collection View Delegate
extension FollowerListVC: UICollectionViewDelegate {
	
	// less calls than for scrollViewDidScroll
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		
		if UIHelper.didUserScrollToEnd(of: scrollView) {
			guard hasMoreFollowers, !isLoadingFollowers, !isSearching else { return }
			page += 1
			getFollowers(username: username, page: page)
			
		}
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(indexPath)
		
		let activeArray = isSearching ? filteredFollowers : followers
		let follower = activeArray[indexPath.item]
		
		let userVC = UserVC(username: follower.login)
		userVC.delegate = self
		let navigationController = UINavigationController(rootViewController: userVC)
		present(navigationController, animated: true)
	}
}


extension FollowerListVC: UserVCDelegate {
	func didRequestFollowers(for username: String) {
		print(#function)
		self.username = username
		title = username
		followers.removeAll()
		filteredFollowers.removeAll()
		page = 1
		collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
		getFollowers(username: username, page: page)
	}
}
