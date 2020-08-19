//
//  Weather.swift
//  InfotechApp
//
//  Created by Максим Семений on 18.08.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import Foundation

struct WeatherInfo: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Main: Codable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity

    }
}

struct Weather: Codable {
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case main
        case icon
        case weatherDescription = "description"
    }
}

struct Wind: Codable {
    let speed: Double
}
