//
//  SceneDelegate.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/18/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = MainTabBarController()
		window.makeKeyAndVisible()
		self.window = window

		//TODO: - legacy implementation - difference?
		//window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		//window?.windowScene = windowScene
		//window?.rootViewController = MainTabBarController()
		//window?.makeKeyAndVisible()
	}
}

