//
//  GFTitleLabel.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/19/23.
//

import UIKit

class GFTitleLabel: UILabel {
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	
	convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
		self.init(frame: .zero) // convenience init calling designated init
		self.textAlignment = textAlignment
		self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
	}
	
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		textColor = .label // supports light/dark mode
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail
	}
}
