//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import Foundation



extension String {
	
	// reusable function to convert string from api to date object
	func convertToDate() -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // format should be exact
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = .current
		
		return dateFormatter.date(from: self) // if format doesn't match - nil
	}
	
	
	// app specific function to chain two extesions together to get date to display
	func convertToDisplayFormat() -> String {
		guard let date = self.convertToDate() else { return "N/A" }
		return date.convertToMonthYearFormat()
	}
}
