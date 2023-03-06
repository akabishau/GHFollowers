//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 3/6/23.
//

import Foundation

//TODO: - is it efficient to work with whole array every time or single values are better?
// enum (no struct) - to avoid possible empty initialization

enum PersistenceManager {
	
	static private let defaults = UserDefaults.standard
	
	private enum Keys {
		static let favorites = "favorites"
	}
	
	enum ActionType {
		case add
		case remove
	}
	
	
	static func save(favorites: [Follower]) -> GFError? {
		do {
			let encoder = JSONEncoder()
			let encodedFavorites = try encoder.encode(favorites)
			defaults.set(encodedFavorites, forKey: Keys.favorites)
			return nil
		} catch {
			return .unableToFavorite
		}
	}
	
	
	//TODO: - is it necessary to use completion handler there (tutorial logic)
	static func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
		
		//TODO: - test dataForKey method instead
		guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
			completion(.success([])) // empty array - nothing is saved yet
			return
		}
		
		do {
			let decoder = JSONDecoder()
			let favorites = try decoder.decode([Follower].self, from: favoritesData)
			completion(.success(favorites))
		} catch {
			completion(.failure(.unableToFavorite)) // from tutorial - doesn't really make sense here
		}
	}
	
	
	//TODO: - is it necessary to use completion handler there (tutorial logic)
	static func updateWith(favorite: Follower, actionType: ActionType, completion: @escaping (GFError?) -> Void) {
		
		retrieveFavorites { result in
			switch result {
				// mutable array (var vs let) to avoid creating a copy of it
				case .success (var favorites):
					switch actionType {
						case .add:
							guard !favorites.contains(favorite) else {
								completion(.alreadyInFavorites)
								return
							}
							favorites.append(favorite)
						case .remove:
							// using removeAll(where: )
							favorites.removeAll { $0.login == favorite.login }
					}
					
					// save changes -> nil/success or error/failure
					completion(save(favorites: favorites))
					
				case .failure(let error):
					completion(error) // pass the error from retrieve call
			}
		}
	}
}
