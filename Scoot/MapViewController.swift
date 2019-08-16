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
    
    // MARK: - Injected Properties
    
    let mainView: MapView
    let locationManager: CLLocationManager
    
    
    // MARK: - Initializers
    
    init(mainView: MapView = .init(), locationManager: CLLocationManager = .init()) {
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
    
    private func setupLocationManager() {
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
    }
}
