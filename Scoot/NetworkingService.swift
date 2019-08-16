//
//  NetworkingService.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import Foundation

final class NetworkingService {
    
    // MARK: - Instance Properties
    
    private var scooters = [Scooter]()
    
    // MARK: Injected Properties
    
    private let session: URLSession
    
    
    // MARK: Initializer
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    // MARK: - APIs
    
    func getScooters(completion: @escaping (Result<[Scooter], Error>) -> Void) {
        completion(.success(scooters))
    }
    
    func create(_ scooter: Scooter, completion: @escaping (Result<Scooter, Error>) -> Void) {
        scooters.append(scooter)
        completion(.success(scooter))
    }
}
