//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 3/9/23.
//

import UIKit

extension UITableView {
	
	func removeExcessCells() {
		tableFooterView = UIView(frame: .zero)
	}
	
	
	func reloadDataOnMainThread () {
		DispatchQueue.main.async {
			self.reloadData()
		}
	}
}
