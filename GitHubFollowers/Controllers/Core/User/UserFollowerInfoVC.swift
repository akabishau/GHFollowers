//
//  FollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import UIKit

protocol UserFollowerInfoVCDelegate: AnyObject {
	func didTappGetFollowers(for user: User)
}


class UserFollowerInfoVC: UserItemInfoVC {
	
	weak var delegate: UserFollowerInfoVCDelegate?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	
	override func actionButtonTapped() {
		print(#function)
		delegate?.didTappGetFollowers(for: user)
	}
	
	
	private func configureItems() {
		leftItemView.set(infoType: .followers, withCount: user.followers)
		rightItemView.set(infoType: .followings, withCount: user.following)
		actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
	}
}
