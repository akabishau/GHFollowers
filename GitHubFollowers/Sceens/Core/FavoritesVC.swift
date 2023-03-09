//
//  FavoritesVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/19/23.
//

import UIKit

final class FavoritesVC: GFDataLoadingVC {
	
	private let tableView = UITableView()
	private var favorites: [Follower] = []
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		configureTableView()
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavorites()
	}
	
	
	private func getFavorites() {
		PersistenceManager.retrieveFavorites { [weak self] (result) in
			guard let self = self else { return }
			
			switch result {
				case .success(let favorites):
					self.favorites = favorites
					self.updateUI(with: favorites)
				case .failure(let error):
					self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
			}
		}
	}
	
	
	private func updateUI(with favorites: [Follower]) {
		print(#function)
		if favorites.isEmpty {
			showEmptyStateView(with: "No favorites?\nAdd one on the follower screen", in: view)
		} else {
			DispatchQueue.main.async {
				self.tableView.reloadData()
				self.view.bringSubviewToFront(self.tableView)
			}
		}
	}

	
	
	private func configureViewController () {
		view.backgroundColor = .systemBackground
		title = "Favorites"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	
	private func configureTableView() {
		view.addSubview(tableView)
		tableView.frame = view.bounds
		tableView.rowHeight = 80
		tableView.removeExcessCells() // seems like it's not an issue anymore
		
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
	}
}


extension FavoritesVC: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favorite = favorites[indexPath.row]
		let destinationVC = FollowerListVC(username: favorite.login)
		
		navigationController?.pushViewController(destinationVC, animated: true)
	}
}


extension FavoritesVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favorites.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
		cell.set(favorite: favorites[indexPath.row])
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		
		guard editingStyle == .delete else { return }
		
		let favorite = favorites[indexPath.row]
		
		PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
			
			guard let self = self else { return }
			if let error = error {
				self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")
			} else {
				self.favorites.remove(at: indexPath.row)
				tableView.deleteRows(at: [indexPath], with: .left)
				if self.favorites.isEmpty {
					self.updateUI(with: self.favorites)
				}
			}
		}
	}
}
