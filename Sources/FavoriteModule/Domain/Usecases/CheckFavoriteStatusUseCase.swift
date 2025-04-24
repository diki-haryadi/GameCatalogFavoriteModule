//
//  CheckFavoriteStatusUseCase.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation
import CoreModule

public class CheckFavoriteStatusUseCase: UseCase {
    public typealias Parameters = String
    public typealias ReturnType = Bool
    
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(parameters: String) async -> Result<Bool, Error> {
        let isFavorite = repository.isFavorite(id: parameters)
        return .success(isFavorite)
    }
}
