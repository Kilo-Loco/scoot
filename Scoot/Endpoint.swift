//
//  Endpoint.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    var url: URL { return URL(string: baseUrl + path)! }
}
