//
//  FavoriteItemDTO.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation

struct FavoriteItemDTO: Decodable {
    let id: String
    let title: String
    let description: String
    let imageUrl: String
    let category: String
    let addedAt: String
    
    func toDomain() -> FavoriteItem {
        return FavoriteItem(
            id: id,
            title: title,
            description: description,
            imageUrl: imageUrl,
            category: category,
            addedAt: DateFormatter.iso8601.date(from: addedAt) ?? Date()
        )
    }
}
