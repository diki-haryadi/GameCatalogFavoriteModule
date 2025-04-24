//
//  GetFavoritesUseCase.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation
import CoreModule

public class GetFavoritesUseCase: UseCase {
    public typealias Parameters = Void
    public typealias ReturnType = [FavoriteItem]
    
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(parameters: Void) async -> Result<[FavoriteItem], Error> {
        do {
            let favorites = try await repository.getFavorites()
            return .success(favorites)
        } catch {
            return .failure(error)
        }
    }
}
