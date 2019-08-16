//
//  SessionCoordinator.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit

final class SessionCoordinator {
    
    // MARK: - Injected Properties
    
    private let rootViewController: UITabBarController
    private let context: SessionContext
    
    
    // MARK: - Initializer
    
    init(rootViewController: UITabBarController = .init(), context: SessionContext = .init()) {
        self.rootViewController = rootViewController
        self.context = context
    }
    
    
    // MARK: - Setup
    
    func startSession() {
        let scooterMapVC = ScooterMapViewController()
        scooterMapVC.title = "Map"
        scooterMapVC.getScooters = { [weak self, unowned scooterMapVC] in
            self?.context.getScooters { [unowned scooterMapVC] result in
                self?.handle(result, for: scooterMapVC)
            }
        }
        
        let scooterListVC = ScooterListViewController()
        scooterListVC.title = "List"
        scooterListVC.getScooters = { [weak self, unowned scooterListVC] in
            self?.context.getScooters { [unowned scooterListVC] result in
                self?.handle(result, for: scooterListVC)
            }
        }
        
        rootViewController.setViewControllers([scooterMapVC, scooterListVC], animated: false)
    }
    
    
    // MARK: - Context Interaction
    
    private func handle(_ scootersResult: Result<[Scooter], Error>, for controller: HasScooters) {
        switch scootersResult {
        case .success(let scooters):
            controller.scooters = scooters
            
        case .failure(let error):
            print(error)
        }
    }
    
}
