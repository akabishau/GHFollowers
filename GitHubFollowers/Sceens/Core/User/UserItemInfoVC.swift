//
//  UserItemInfoVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import UIKit

class UserItemInfoVC: UIViewController {
	
	private let stackView = UIStackView()
	let leftItemView = UserItemInfoView()
	let rightItemView = UserItemInfoView()
	let actionButton = GFButton()
	
	let user: User
	
	init(user: User) {
		self.user = user
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
	}
	
	
	@objc func actionButtonTapped() { } // overriden on subclass

	
	//TODO: - Refactor using stack view only
	private func configure() {
		view.layer.cornerRadius = 18
		view.backgroundColor = .secondarySystemBackground
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		
		stackView.addArrangedSubview(leftItemView)
		stackView.addArrangedSubview(rightItemView)
		
		actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
		
		view.addSubview(stackView)
		view.addSubview(actionButton)
		
		let padding: CGFloat = 20
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			stackView.heightAnchor.constraint(equalToConstant: 50),
			
			actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}
}
