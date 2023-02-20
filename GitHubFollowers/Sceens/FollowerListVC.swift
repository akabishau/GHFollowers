//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/19/23.
//

import UIKit

class FollowerListVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
}
