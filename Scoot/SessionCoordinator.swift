//
//  SessionCoordinator.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit
import CoreLocation

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
        scooterMapVC.didProvideCoordinates = { [weak self, unowned scooterMapVC] in
            self?.createScooterAlert(with: $0, in: scooterMapVC) { [unowned scooterMapVC] scooter in
                scooterMapVC.createAnnotation(for: scooter)
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
    
    
    // MARK: - Alerts
    
    private func createScooterAlert(with coordinate: CLLocationCoordinate2D, in viewController: UIViewController, completion: @escaping (Scooter) -> Void) {
        
        let alert = UIAlertController(title: "Create Scooter", message: nil, preferredStyle: .alert)
        alert.addTextField {
            $0.placeholder = "Enter scooter name"
        }
        let createAction = UIAlertAction(title: "Add", style: .default) { [unowned alert] _ in
            guard let scooterName = alert.textFields?.first?.text else { return }
            let coordinates = Coordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let newScooter = Scooter(id: nil, name: scooterName, coordinates: coordinates)
            completion(newScooter)
        }
        alert.addAction(createAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        viewController.present(alert, animated: true)
    }
    
}
