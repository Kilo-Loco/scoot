//
//  ScooterMapView.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit
import MapKit

final class ScooterMapView: UIView {
    
    // MARK: - Communication
    
    var didProvideCoordinate: ((CLLocationCoordinate2D) -> Void)?
    
    
    // MARK: - Subviews
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var addScooterButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "addButtonIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        addSubview(mapView)
        addSubview(addScooterButton)
    }
    
    
    // MARK: - Events
    
    @objc
    private func didTapAddButton() {
        didProvideCoordinate?(mapView.centerCoordinate)
    }
    
}
