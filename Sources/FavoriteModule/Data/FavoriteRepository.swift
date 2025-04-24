//
//  FavoriteRepository.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation
import CoreModule

public class FavoriteRepository: FavoriteRepositoryProtocol {
    private let remoteDataSource: FavoriteRemoteDataSource
    private let localDataSource: FavoriteLocalDataSource
    private let logger = Logger(category: "FavoriteRepository")
    
    public init(
        remoteDataSource: FavoriteRemoteDataSource,
        localDataSource: FavoriteLocalDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    public func getFavorites() async throws -> [FavoriteItem] {
        do {
            // Get local favorite IDs
            let localFavoriteIds = localDataSource.getFavoriteIds()
            
            // If we have favorites locally, fetch their details
            if !localFavoriteIds.isEmpty {
                // Try to get from local cache first
                if let cached = try? localDataSource.getCachedFavorites() {
                    logger.log("Returning cached favorites", level: .debug)
                    return cached
                }
                
                // Fetch details from remote
                logger.log("Fetching remote favorites", level: .debug)
                let favorites = try await remoteDataSource.fetchFavorites()
                
                // Cache the results
                try localDataSource.cacheFavorites(favorites)
                
                return favorites
            } else {
                // No favorites, return empty array
                return []
            }
        } catch {
            // If remote fails, try to get from cache
            if let cached = try? localDataSource.getCachedFavorites() {
                logger.log("Remote fetch failed, using cached favorites", level: .warning)
                return cached
            }
            throw error
        }
    }
    
    public func addFavorite(id: String) async throws {
        try await remoteDataSource.addToFavorites(id: id)
        localDataSource.addFavoriteId(id: id)
    }
    
    public func removeFavorite(id: String) async throws {
        try await remoteDataSource.removeFromFavorites(id: id)
        localDataSource.removeFavoriteId(id: id)
    }
    
    public func isFavorite(id: String) -> Bool {
        return localDataSource.isFavorite(id: id)
    }
}
