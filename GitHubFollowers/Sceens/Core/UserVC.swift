//
//  UserVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/22/23.
//

import UIKit

final class UserVC: UIViewController {
	
	let username: String
	
	init(username: String!) {
		self.username = username
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureViewController()
		getUserInfo()
	}
	
	
	private func configureViewController() {
		view.backgroundColor = .systemBackground
		title = username
		
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		navigationItem.rightBarButtonItem = doneButton
		
	}
	
	
	@objc private func dismissVC() {
		dismiss(animated: true)
	}
	
	
	private func getUserInfo() {
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }
			switch result {
				case .success(let user):
					DispatchQueue.main.async {
						print(user)
						// update ui elements
					}
				case .failure(let error):
					self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
			}
		}
	}
}
