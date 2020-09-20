//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Ahmed on 8/2/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

enum persistenceActionType {
    
    case add, remove
    
}

enum PersistenceManager {
    
    static private let defults = UserDefaults.standard
    
    enum Keys {
        
        static let favorites = "favorites"
        
    }
    
    static func updateWith(favorite: Follower, actionType: persistenceActionType, completed: @escaping (GFError?) -> Void) {
        
        retrieveFavorites { result in
            
            switch result {
                
            case .success(let favorites):
                
                var retrievedFavorites = favorites
                
                switch actionType {
                
                case .add:
                    
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    
                    retrievedFavorites.removeAll {
                        $0.login == favorite.login
                    }
                }
                
                completed(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completed(error)
            }
            
        }
        
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower],GFError>) -> Void) {
        
        guard let favoritesData = defults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
            
        }
        do {
            
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
            
        } catch {
            
            //completed(nil,error.localizedDescription)
            completed(.failure(.unableToFavorite))
    
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
            
        } catch  {
            
            return .unableToFavorite
            
        }
    }
}
