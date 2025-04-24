//
//  RemoveFavoriteUseCase.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation
import CoreModule

public class RemoveFavoriteUseCase: UseCase {
    public typealias Parameters = String
    public typealias ReturnType = Bool
    
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(parameters: String) async -> Result<Bool, Error> {
        do {
            try await repository.removeFavorite(id: parameters)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}
