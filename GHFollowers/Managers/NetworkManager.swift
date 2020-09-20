//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Ahmed on 7/17/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers (for userName: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void){
        
        let endPoint = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else{
            completed(.failure(.invalidUserName))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                
                completed(.failure(.unableToComplete))
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                completed(.failure(.invalidResponse))
                
                return
            }
            
            guard let data = data else{
                
                completed(.failure(.invalidData))
                
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let follower = try decoder.decode([Follower].self, from: data)
                completed(.success(follower))
                
            } catch {
                
                //completed(nil,error.localizedDescription)
                completed(.failure(.invalidData))
                
            }
        }
        task.resume()
    }
    func getUserInfo (for userName: String, completed: @escaping (Result<User, GFError>) -> Void){
        
        let endPoint = baseURL + "\(userName)"
        
        guard let url = URL(string: endPoint) else{
            completed(.failure(.invalidUserName))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                
                completed(.failure(.unableToComplete))
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                completed(.failure(.invalidResponse))
                
                return
            }
            
            guard let data = data else{
                
                completed(.failure(.invalidData))
                
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
                
            } catch {
                
                //completed(nil,error.localizedDescription)
                completed(.failure(.invalidData))
                
            }
        }
        task.resume()
    }
    
}
