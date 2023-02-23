//
//  GFSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import UIKit

final class GFSecondaryTitleLabel: UILabel {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	convenience init(fontSize: CGFloat) {
		self.init(frame: .zero) // convenience init calling designated init
		font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail // textBreaksTher...
	}
}
