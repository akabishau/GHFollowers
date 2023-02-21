//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/20/23.
//

import UIKit

struct UIHelper {
	
	static func createThreeColumnFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
		
		let width = view.bounds.width
		let padding: CGFloat = 12
		let minItemSpacing: CGFloat = 10
		let availableWidth = width - padding * 2 - minItemSpacing * 2
		let itemWidth = availableWidth / 3
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
		return flowLayout
	}
	
	
	static func didUserScrollToEnd(of scrollView: UIScrollView) -> Bool {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height
		
		return offsetY > (contentHeight - height)
	}
}
