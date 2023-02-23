//
//  InfoItemView.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import UIKit

enum UserItemInfoType {
	case repos
	case gists
	case followers
	case followings
}


class UserItemInfoView: UIView {
	
	let symbolImageView = UIImageView()
	let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
	let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	func set(infoType: UserItemInfoType, withCount count: Int) {
		switch infoType {
			case .repos:
				symbolImageView.image = SFSymbols.repos
				titleLabel.text = "Public Repos"
			case .gists:
				symbolImageView.image = SFSymbols.gists
				titleLabel.text = "Public Gists"
			case .followers:
				symbolImageView.image = SFSymbols.followers
				titleLabel.text = "Followers"
			case .followings:
				symbolImageView.image = SFSymbols.following
				titleLabel.text = "Following"
		}
		
		countLabel.text = String(count)
	}
	
	
	private func configure() {
		addSubview(symbolImageView)
		addSubview(titleLabel)
		addSubview(countLabel)
		
		symbolImageView.translatesAutoresizingMaskIntoConstraints = false
		symbolImageView.contentMode = .scaleAspectFill // because different sf symbols
		symbolImageView.tintColor = .label
		
		NSLayoutConstraint.activate([
			symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
			symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			symbolImageView.widthAnchor.constraint(equalToConstant: 20),
			symbolImageView.heightAnchor.constraint(equalToConstant: 20),
			
			titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			titleLabel.heightAnchor.constraint(equalToConstant: 18), // font size + 4
			
			countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
			countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			countLabel.heightAnchor.constraint(equalToConstant: 18)
		])
	}
}
