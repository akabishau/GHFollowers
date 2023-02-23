//
//  RepoItemVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import UIKit

class RepoItemVC: InfoItemVC {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	
	private func configureItems() {
		leftItemView.set(infoItemType: .repos, withCount: user.publicRepos)
		rightItemView.set(infoItemType: .gists, withCount: user.publicGists)
		actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
	}
}
