//
//  ScooterMapViewController.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit
import CoreLocation

final class ScooterMapViewController: UIViewController {
    
    // MARK: - Communication
    
    var getScooters: EmptyClosure?
    
    
    // MARK: - Instance Properties
    
    var scooters = [Scooter]()
    
    // MARK: Injected Properties
    
    let mainView: ScooterMapView
    let locationManager: CLLocationManager
    
    
    // MARK: - Initializers
    
    init(mainView: ScooterMapView = .init(), locationManager: CLLocationManager = .init()) {
        self.mainView = mainView
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    
    // MARK: - Setup
    
    private func setupMainView() {
        mainView.didProvideCoordinate = { coordinates in
            
        }
    }
    
    private func setupLocationManager() {
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
}


extension ScooterMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
    }
}

extension ScooterMapViewController: HasScooters {}
