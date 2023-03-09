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
	
	
	var isUsernameEntered: Bool {
		return !usernameTextField.text!.isEmpty
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		configureLogoImageView()
		configureUsernameTextField()
		configureCallToActionButton()
		createDismissKeyboardTapGesture()
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	
	@objc func pushFollowerListVC() {
		
		guard isUsernameEntered else {
			presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look up for 😀.", buttonTitle: "OK")
			return
		}
		
		let followerListVC = FollowerListVC(username: usernameTextField.text!)
		navigationController?.pushViewController(followerListVC, animated: true)
		usernameTextField.text = ""
		usernameTextField.resignFirstResponder()
		//view.endEditing(true) // the same effect as line above
	}
	
	
	private func createDismissKeyboardTapGesture() {
		let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
		view.addGestureRecognizer(tap)
	}
	
	
	private func configureLogoImageView() {
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(logoImageView)
		
		let topConstraint: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
		
		logoImageView.image = Images.ghLogo
		
		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraint),
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: 200),
			logoImageView.widthAnchor.constraint(equalToConstant: 200)
		])
	}
	
	
	private func configureUsernameTextField() {
		view.addSubview(usernameTextField)
		usernameTextField.delegate = self
		
		NSLayoutConstraint.activate([
			usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: padding),
			usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			usernameTextField.heightAnchor.constraint(equalToConstant: padding)
		])
	}
	
	
	private func configureCallToActionButton() {
		view.addSubview(callToActionButton)
		
		callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
			callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			callToActionButton.heightAnchor.constraint(equalToConstant: padding)
		])
	}
}


extension SearchVC: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		pushFollowerListVC()
		return true
	}
}
