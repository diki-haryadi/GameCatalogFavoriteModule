//
//  FavoriteViewModel.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation
import Combine
import CoreModule

public class FavoriteViewModel: ObservableObject {
    private let getFavoritesUseCase: GetFavoritesUseCase
    private let removeFavoriteUseCase: RemoveFavoriteUseCase
    private let logger = Logger(category: "FavoriteViewModel")
    
    @Published public var favorites: [FavoriteItem] = []
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String?
    
    public init(
        getFavoritesUseCase: GetFavoritesUseCase,
        removeFavoriteUseCase: RemoveFavoriteUseCase
    ) {
        self.getFavoritesUseCase = getFavoritesUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
    }
    
    public func loadFavorites() {
        isLoading = true
        errorMessage = nil
        
        Task {
            let result = await getFavoritesUseCase.execute()
            
            await MainActor.run {
                self.isLoading = false
                
                switch result {
                case .success(let items):
                    self.favorites = items
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.logger.log("Error loading favorites: \(error.localizedDescription)", level: .error)
                }
            }
        }
    }
    
    public func removeFavorite(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let itemToRemove = favorites[index]
        
        // Optimistically update UI
        favorites.remove(at: index)
        
        Task {
            let result = await removeFavoriteUseCase.execute(parameters: itemToRemove.id)
            
            if case .failure(let error) = result {
                // Restore item if removal failed
                await MainActor.run {
                    self.favorites.insert(itemToRemove, at: index)
                    self.logger.log("Failed to remove favorite: \(error.localizedDescription)", level: .error)
                }
            }
        }
    }
    
    public func refreshData() {
        loadFavorites()
    }
}
