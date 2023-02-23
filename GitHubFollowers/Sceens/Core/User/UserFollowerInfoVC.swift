//
//  FollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import UIKit


class UserFollowerInfoVC: UserItemInfoVC {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	
	private func configureItems() {
		leftItemView.set(infoType: .followers, withCount: user.followers)
		rightItemView.set(infoType: .followings, withCount: user.following)
		actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
	}
}
