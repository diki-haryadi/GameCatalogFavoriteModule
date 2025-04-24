//
//  SearchCoordinator.swift
//  GameCatalogMain
//
//  Created by ben on 23/04/25.
//

import Foundation
import UIKit
import SwiftUI
import CoreModule

public protocol SearchCoordinator {
    func start() -> UIViewController
    func navigateToDetail(itemId: String)
}

public class DefaultSearchCoordinator: SearchCoordinator {
    private let navigationController: UINavigationController
    private let moduleFactory: ModuleFactoryProtocol
    private let searchViewModel: SearchViewModel
    
    public init(
        navigationController: UINavigationController,
        moduleFactory: ModuleFactoryProtocol,
        searchViewModel: SearchViewModel
    ) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
        self.searchViewModel = searchViewModel
    }
    
    public func start() -> UIViewController {
        let searchView = SearchView(viewModel: searchViewModel, coordinator: self)
        let hostingController = UIHostingController(rootView: searchView)
        navigationController.viewControllers = [hostingController]
        return navigationController
    }
    
    public func navigateToDetail(itemId: String) {
        guard let detailViewController = moduleFactory.makeDetailModule(itemId: itemId) else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
