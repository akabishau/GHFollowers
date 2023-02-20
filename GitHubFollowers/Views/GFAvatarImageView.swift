//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/20/23.
//

import UIKit

class GFAvatarImageView: UIImageView {
	
	let placeholderImage = Images.placeholder
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = 10
		clipsToBounds = true
		image = placeholderImage
	}
}
