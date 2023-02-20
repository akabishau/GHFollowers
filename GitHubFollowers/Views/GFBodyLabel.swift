//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/19/23.
//

import UIKit

class GFBodyLabel: UILabel {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	
	convenience init(textAlignment: NSTextAlignment) {
		self.init(frame: .zero) // convenience init calling designated init
		self.textAlignment = textAlignment
	}
	
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.75
		lineBreakMode = .byWordWrapping
		font = UIFont.preferredFont(forTextStyle: .body)
		adjustsFontForContentSizeCategory = true
	}
}
