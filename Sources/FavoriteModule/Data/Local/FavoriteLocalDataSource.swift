//
//  FavoriteLocalDataSource.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation
import CoreModule

public class FavoriteLocalDataSource {
    private let localStorage: LocalStorageProtocol
    private let sharedPreferences: SharedPreferences
    private let logger = Logger(category: "FavoriteLocalDataSource")
    
    // Keys
    private enum Keys {
        static let cachedFavorites = "cached_favorites"
    }
    
    public init(localStorage: LocalStorageProtocol, sharedPreferences: SharedPreferences) {
        self.localStorage = localStorage
        self.sharedPreferences = sharedPreferences
    }
    
    func getFavoriteIds() -> [String] {
        return sharedPreferences.getFavoriteIds()
    }
    
    func addFavoriteId(id: String) {
        sharedPreferences.addFavorite(id: id)
    }
    
    func removeFavoriteId(id: String) {
        sharedPreferences.removeFavorite(id: id)
    }
    
    func isFavorite(id: String) -> Bool {
        return sharedPreferences.isFavorite(id: id)
    }
    
    func getCachedFavorites() throws -> [FavoriteItem]? {
        return try localStorage.get(forKey: Keys.cachedFavorites)
    }
    
    func cacheFavorites(_ favorites: [FavoriteItem]) throws {
        try localStorage.save(favorites, forKey: Keys.cachedFavorites)
    }
    
    func clearCachedFavorites() {
        localStorage.remove(forKey: Keys.cachedFavorites)
    }
}
