//
//  Coordinator.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var rootViewController: UIViewController { get }
    func start()
    func addChild(_ child: Coordinator)
    func removeChild(_ child: Coordinator)
}

extension Coordinator {
    
    func addChild(_ coordinator: Coordinator) {
        guard coordinator.parentCoordinator == nil, !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }
    
    func removeChild(_ coordinator: Coordinator) {
        guard coordinator.parentCoordinator === self, childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.removeAll { $0 === coordinator }
        coordinator.parentCoordinator = nil
    }
}
