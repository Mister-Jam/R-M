//
//  ApplicationCoordinator.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import UIKit
import SwiftUI

final class ApplicationCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    var rootViewController: UIViewController
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, 
         _ window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        self.rootViewController = navigationController
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func start() {
        showListController()
    }
    
    private func showListController() {
        let viewModel = ListViewModel(pageTitle: "R & M Characters")
        viewModel.didSelectItem = { [weak self] selectedCharacter in
            self?.showDetailsScreen(characterData: selectedCharacter)
        }

        let viewController = ListViewController(viewModel: viewModel)
        navigationController.show(viewController, sender: self)
    }
    
    private func showDetailsScreen(characterData: ListItemCellModel) {
        let view = CharacterDetailsView(characterDetails: characterData.characterDetails)
        let hostingController = UIHostingController(rootView: view)
        navigationController.show(hostingController, sender: self)
    }
}
