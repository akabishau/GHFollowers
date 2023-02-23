//
//  UserRepoInfoVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import UIKit

class UserRepoInfoVC: UserItemInfoVC {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	
	private func configureItems() {
		leftItemView.set(infoType: .repos, withCount: user.publicRepos)
		rightItemView.set(infoType: .gists, withCount: user.publicGists)
		actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
	}
}
