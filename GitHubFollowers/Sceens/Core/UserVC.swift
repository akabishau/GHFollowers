//
//  UserVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/22/23.
//

import UIKit

final class UserVC: UIViewController {
	
	let headerView = UIView()
	
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
		self.add(childVC: UserHeaderVC(user: user), to: self.headerView)
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
		
		headerView.translatesAutoresizingMaskIntoConstraints = false
		headerView.backgroundColor = .systemPink
		
		view.addSubview(headerView)
		
		
		NSLayoutConstraint.activate([
			headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			headerView.heightAnchor.constraint(equalToConstant: 190)
		])

	}
}
