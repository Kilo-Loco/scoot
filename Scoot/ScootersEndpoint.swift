//
//  ScootersEndpoint.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import Foundation

struct ScootersEndpoint: Endpoint {
    let baseUrl: String
    let path: String
    let method: HTTPMethod
    let bodyObject: Encodable?
    
    init(baseUrl: String = "https://boiling-shelf-13846.herokuapp.com",
         path: String,
         method: HTTPMethod = .get,
         bodyObject: Encodable? = nil) {
        
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.bodyObject = bodyObject
    }
}

extension ScootersEndpoint {
    
    static func getScooters() -> ScootersEndpoint {
        return .init(path: "scooters")
    }
    
    static func create(_ scooter: Scooter) -> ScootersEndpoint {
        return .init(path: "scooters", method: .post, bodyObject: scooter)
    }
}
