//
//  HasScooters.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import Foundation

protocol HasScooters: AnyObject {
    var scooters: [Scooter] { get set }
}
