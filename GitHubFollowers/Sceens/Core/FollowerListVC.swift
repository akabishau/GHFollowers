//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/19/23.
//

import UIKit

class FollowerListVC: UIViewController {
	
	var followers: [Follower] = []
	
	var username: String!
	var page = 1
	
	
	init(username: String) {
		super.init(nibName: nil, bundle: nil)
		self.username = username
		title = username
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
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
					self.followers = followers
					print(followers.count)
				case .failure(let error):
					print("failed: \(error.rawValue)")
					self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
					DispatchQueue.main.async {
						self.navigationController?.popViewController(animated: true)
					}
			}
		}
	}
}
