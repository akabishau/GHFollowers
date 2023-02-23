//
//  FollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import UIKit


class FollowerItemVC: InfoItemVC {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	
	private func configureItems() {
		leftItemView.set(infoItemType: .followers, withCount: user.followers)
		rightItemView.set(infoItemType: .followings, withCount: user.following)
		actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
	}
}
