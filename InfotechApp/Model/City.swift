//
//  City.swift
//  InfotechApp
//
//  Created by Максим Семений on 18.08.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let state: String?
    let country: String
    let coord: Coordinates
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}
