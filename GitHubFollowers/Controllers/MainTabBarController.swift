//
//  ViewController.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/18/23.
//

import UIKit

class MainTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewControllers = [createSearchNC(), createFavoritesNC()]
		configureAppAppearance()
	}
	
	
	private func createSearchNC() -> UINavigationController {
		let searchVC = SearchVC()
		searchVC.title = "Search"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: searchVC)
	}
	
	
	private func createFavoritesNC() -> UINavigationController {
		let favoritesVC = FavoritesVC()
		favoritesVC.title = "Favorites"
		favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		return UINavigationController(rootViewController: favoritesVC)
	}
	
	
	private func configureAppAppearance() {
		UINavigationBar.appearance().tintColor = .systemGreen
		UITabBar.appearance().tintColor = .systemGreen
	}
}
