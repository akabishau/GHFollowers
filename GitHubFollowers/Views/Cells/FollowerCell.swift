//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/20/23.
//

import UIKit

class FollowerCell: UICollectionViewCell {
	
	static let reuseId = String(describing: FollowerCell.self)
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func prepareForReuse() {
		super.prepareForReuse()
		avatarImageView.image = nil
		usernameLabel.text = ""
	}
	
	
	func set(follower: Follower) {
		usernameLabel.text = follower.login
		avatarImageView.downloadImage(from: follower.avatarUrl)
	}
	
	
	private func configure() {

		addSubview(avatarImageView)
		addSubview(usernameLabel)
		
		let padding: CGFloat = 8
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
			
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
			usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			usernameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
	
	
}
