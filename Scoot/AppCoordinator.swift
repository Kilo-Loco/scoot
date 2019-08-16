//
//  AppCoordinator.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Instance Properties
    
    private var childCoordinator: Any?
    
    // MARK: Injected Properties
    
    private let window: UIWindow
    
    
    // MARK: - Initializer
    
    init(window: UIWindow = .init(frame: UIScreen.main.bounds)) {
        self.window = window
    }
    
    
    // MARK: - Events
    
    func didFinishLaunching() -> Bool {
        window.rootViewController = InitialViewController()
        window.makeKeyAndVisible()
        return didStartSubFlow()
    }
    
    private func didStartSubFlow() -> Bool {
        let sessionTabBarController = UITabBarController()
        let sessionCoordinator = SessionCoordinator(rootViewController: sessionTabBarController)
        childCoordinator = sessionCoordinator
        sessionCoordinator.startSession()
        window.rootViewController = sessionTabBarController
        return true
    }
}
