//
//  FavoriteRepositoryProtocol.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation

public protocol FavoriteRepositoryProtocol {
    func getFavorites() async throws -> [FavoriteItem]
    func addFavorite(id: String) async throws
    func removeFavorite(id: String) async throws
    func isFavorite(id: String) -> Bool
}
