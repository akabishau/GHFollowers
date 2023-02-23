//
//  UserVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/22/23.
//

import UIKit

final class UserVC: UIViewController {
	
	let headerInfoView = UIView()
	let repoInfoView = UIView()
	let followerInfoView = UIView()
	let dateLabel = GFBodyLabel(textAlignment: .center)
	
	let username: String
	
	init(username: String!) {
		self.username = username
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureViewController()
		layoutUI()
		getUserInfo()
	}
	
	
	private func getUserInfo() {
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }
			switch result {
				case .success(let user):
					DispatchQueue.main.async {
						DispatchQueue.main.async {
							self.configureUIElements(with: user)
						}
					}
				case .failure(let error):
					self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
			}
		}
	}
	
	
	private func configureUIElements(with user: User) {
		add(childVC: UserHeadeInfoVC(user: user), to: headerInfoView)
		add(childVC: UserRepoInfoVC(user: user), to: repoInfoView)
		add(childVC: UserFollowerInfoVC(user: user), to: followerInfoView)
		dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
	}
	
	
	
	private func add(childVC: UIViewController, to containerView: UIView) {
		addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
	}
	
	
	private func configureViewController() {
		view.backgroundColor = .systemBackground
		
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		navigationItem.rightBarButtonItem = doneButton
	}
	
	
	@objc private func dismissVC() {
		dismiss(animated: true)
	}
	
	
	private func layoutUI() {
		
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 140
		
		headerInfoView.translatesAutoresizingMaskIntoConstraints = false
		repoInfoView.translatesAutoresizingMaskIntoConstraints = false
		followerInfoView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(headerInfoView)
		view.addSubview(repoInfoView)
		view.addSubview(followerInfoView)
		view.addSubview(dateLabel)
		
		NSLayoutConstraint.activate([
			headerInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			headerInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			headerInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			headerInfoView.heightAnchor.constraint(equalToConstant: 190),
			
			
			repoInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			repoInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			repoInfoView.topAnchor.constraint(equalTo: headerInfoView.bottomAnchor, constant: padding),
			repoInfoView.heightAnchor.constraint(equalToConstant: itemHeight),
			
			followerInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			followerInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			followerInfoView.topAnchor.constraint(equalTo: repoInfoView.bottomAnchor, constant: padding),
			followerInfoView.heightAnchor.constraint(equalToConstant: itemHeight),
			
			dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			dateLabel.topAnchor.constraint(equalTo: followerInfoView.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(equalToConstant: 40),
		])

	}
}
