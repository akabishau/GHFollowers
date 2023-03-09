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
	
	
	func downloadImage(from url: String) {
		NetworkManager.shared.downloadImage(from: url) { [weak self] result in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result {
					case .success(let image):
						self.image = image
					case .failure:
						self.image = self.placeholderImage
				}
			}
		}
	}
}
