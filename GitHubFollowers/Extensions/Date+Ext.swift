//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import Foundation

extension Date {
	
	// www.nsdateformatter.com
	
	func convertToMonthYearFormat() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
		return dateFormatter.string(from: self)
	}
}
