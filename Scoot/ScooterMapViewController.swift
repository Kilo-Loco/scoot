//
//  ScooterMapViewController.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class ScooterMapViewController: UIViewController {
    
    // MARK: - Communication
    
    var getScooters: EmptyClosure?
    var didProvideCoordinates: ((CLLocationCoordinate2D) -> Void)?
    
    
    // MARK: - Instance Properties
    
    var scooters = [Scooter]()
    
    // MARK: Injected Properties
    
    let mainView: ScooterMapView
    let locationManager: CLLocationManager
    
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(mainView: .init(), locationManager: .init())
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupLocationManager()
    }
    
    
    // MARK: - Setup
    
    private func setupMainView() {
        mainView.didProvideCoordinate = { [weak self] coordinates in
            self?.didProvideCoordinates?(coordinates)
        }
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    // MARK: - Events
    
    func createAnnotation(for scooter: Scooter) {
        let annotation = MKPointAnnotation()
        annotation.title = scooter.name
        annotation.coordinate = CLLocationCoordinate2D(latitude: scooter.coordinates.latitude,
                                                       longitude: scooter.coordinates.longitude)
        mainView.mapView.addAnnotation(annotation)
    }
}


extension ScooterMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        mainView.mapView.camera.centerCoordinate = location.coordinate
        mainView.mapView.camera.altitude = 500
    }
}

extension ScooterMapViewController: HasScooters {}
