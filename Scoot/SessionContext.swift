//
//  SessionContext.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import Foundation

final class SessionContext {
    
    // MARK: - Injected Properties
    
    private let networking: NetworkingService
    
    
    // MARK: - Initializer
    
    init(networkingService: NetworkingService = .init()) {
        self.networking = networkingService
    }
    
    
    // MARK: - Interactors
    
    func getScooters(completion: @escaping (Result<[Scooter], Error>) -> Void) {
        networking.getScooters(completion: completion)
    }
    
    func create(_ scooter: Scooter, completion: @escaping (Result<Scooter, Error>) -> Void) {
        networking.create(scooter, completion: completion)
    }
}
