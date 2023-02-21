//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/19/23.
//

import UIKit


class NetworkManager {
	
	static let shared = NetworkManager()
	private init() { }
	
	private let baseURL = "https://api.github.com/users/"
	
	private let cache = NSCache<NSString, UIImage>()
	
	
	func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
		
		let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
		print(endPoint)
		
		guard let url = URL(string: endPoint) else {
			completion(.failure(.invalidUsername))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			
			if let _ = error {
				completion(.failure(.unableToComplete))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else {
				completion(.failure(.invalidData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let followers = try decoder.decode([Follower].self, from: data)
				completion(.success(followers))
			} catch {
				completion(.failure(.invalidData))
			}
		}
		task.resume()
	}
	
	
	
	//TODO: - Refactor using Generics
	
	func downloadImage(from urlString: String, completion: @escaping (Result<UIImage, GFError>) -> Void) {
		
		let cacheKey = NSString(string: urlString)
		
		if let image = cache.object(forKey: cacheKey) {
			completion(.success(image))
			return
		}
		
		guard let url = URL(string: urlString) else {
			completion(.failure(.invalidData))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self = self else { return }
			// in case of error the placeholder image will
			if let _ = error {
				completion(.failure(.unableToComplete))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(.failure(.invalidResponse))
				return
			}
			
			guard let data = data, let image = UIImage(data: data) else {
				completion(.failure(.invalidData))
				return
			}
			
			self.cache.setObject(image, forKey: cacheKey)
			completion(.success(image))
		}
		task.resume()
	}
}


