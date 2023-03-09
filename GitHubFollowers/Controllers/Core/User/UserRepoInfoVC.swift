//
//  UserRepoInfoVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import UIKit

protocol UserRepoInfoVCDelegate: AnyObject {
	func didTapGitHubProfile(for user: User)
}


class UserRepoInfoVC: UserItemInfoVC {
	
	weak var delegate: UserRepoInfoVCDelegate?
	
	
	init(user: User, delegate: UserRepoInfoVCDelegate) {
		self.delegate = delegate
		super.init(user: user)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	
	override func actionButtonTapped() {
		delegate?.didTapGitHubProfile(for: user)
	}
	
	
	private func configureItems() {
		leftItemView.set(infoType: .repos, withCount: user.publicRepos)
		rightItemView.set(infoType: .gists, withCount: user.publicGists)
		actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
	}
}
