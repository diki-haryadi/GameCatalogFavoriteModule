//
//  EmptyResponse.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation

struct EmptyResponse: Decodable { }

// FavoriteModule/Sources/FavoriteModule/Domain/Models/FavoriteItem.swift
import Foundation

public struct FavoriteItem: Identifiable, Codable, Equatable {
    public let id: String
    public let title: String
    public let description: String
    public let imageUrl: String
    public let category: String
    public let addedAt: Date
    
    public init(
        id: String,
        title: String,
        description: String,
        imageUrl: String,
        category: String,
        addedAt: Date
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.category = category
        self.addedAt = addedAt
    }
}
