//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/19/23.
//

import UIKit

class SearchVC: UIViewController {
	
	let padding: CGFloat = 50
	
	let logoImageView = UIImageView()
	let usernameTextField = GFTextField()
	let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		configureLogoImageView()
		configureUsernameTextField()
		configureCallToActionButton()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	
	private func configureLogoImageView() {
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(logoImageView)
		
		let topConstraint: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
		
		logoImageView.image = UIImage(named: "gh-logo") // refactor
		
		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraint),
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: 200),
			logoImageView.widthAnchor.constraint(equalToConstant: 200)
		])
	}
	
	
	private func configureUsernameTextField() {
		view.addSubview(usernameTextField)
		
		NSLayoutConstraint.activate([
			usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: padding),
			usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			usernameTextField.heightAnchor.constraint(equalToConstant: padding)
		])
	}
	
	
	private func configureCallToActionButton() {
		view.addSubview(callToActionButton)
		
		NSLayoutConstraint.activate([
			callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
			callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			callToActionButton.heightAnchor.constraint(equalToConstant: padding)
		])
	}
}
