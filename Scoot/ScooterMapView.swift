//
//  ScooterMapView.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit
import MapKit
import Mortar

final class ScooterMapView: UIView {
    
    // MARK: - Communication
    
    var didProvideCoordinate: ((CLLocationCoordinate2D) -> Void)?
    
    
    // MARK: - Subviews
    
    lazy var mapView: MKMapView = { [unowned self] in
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.delegate = self
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
        
        mapView |=| self
        
        addScooterButton.m_centerX |=| m_centerX
        addScooterButton.m_bottom |=| m_bottomMargin - 20
        addScooterButton.m_size |=| (60, 60)
    }
    
    
    // MARK: - Events
    
    @objc
    private func didTapAddButton() {
        didProvideCoordinate?(mapView.centerCoordinate)
    }
    
}

extension ScooterMapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}
