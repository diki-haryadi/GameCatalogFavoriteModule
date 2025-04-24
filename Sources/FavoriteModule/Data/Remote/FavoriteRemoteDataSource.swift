//
//  FavoriteRemoteDataSource.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation
import CoreModule

public class FavoriteRemoteDataSource {
    private let apiService: APIServiceProtocol
    private let logger = Logger(category: "FavoriteRemoteDataSource")
    
    public init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchFavorites() async throws -> [FavoriteItem] {
        logger.log("Fetching favorites from API", level: .debug)
        let endpoint = APIEndpoints.getFavorites
        let favoritesDTO: [FavoriteItemDTO] = try await apiService.request(endpoint: endpoint)
        return favoritesDTO.map { $0.toDomain() }
    }
    
    func addToFavorites(id: String) async throws {
        logger.log("Adding to favorites: \(id)", level: .debug)
        let endpoint = APIEndpoints.addFavorite(itemId: id)
        let _: EmptyResponse = try await apiService.request(endpoint: endpoint)
    }
    
    func removeFromFavorites(id: String) async throws {
        logger.log("Removing from favorites: \(id)", level: .debug)
        let endpoint = APIEndpoints.removeFavorite(itemId: id)
        let _: EmptyResponse = try await apiService.request(endpoint: endpoint)
    }
}
