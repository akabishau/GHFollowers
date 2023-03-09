//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 3/9/23.
//

import UIKit

class FavoriteCell: UITableViewCell {
	
	static let reuseID = "FavoriteCell"
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let userNameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	func set(favorite: Follower) {
		userNameLabel.text = favorite.login
		avatarImageView.downloadImage(from: favorite.avatarUrl)
	}
	
	
	private func configure() {
		addSubview(avatarImageView)
		addSubview(userNameLabel)
		
		accessoryType = .disclosureIndicator
		let padding: CGFloat = 12
		
		NSLayoutConstraint.activate([
			avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			avatarImageView.widthAnchor.constraint(equalToConstant: 60),
			avatarImageView.heightAnchor.constraint(equalToConstant: 60),
			
			userNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
			userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding * 2),
			userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			userNameLabel.heightAnchor.constraint(equalToConstant: 40)
		])
	}
}
