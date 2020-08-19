//
//  CitiesManager.swift
//  InfotechApp
//
//  Created by Максим Семений on 18.08.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

final class CitiesManager {
    static let shared = CitiesManager()
    private let citiesURL = Bundle.main.url(forResource: "city.list", withExtension: "json")
    
    func getCityList(completion: @escaping((_ cities: [City]) -> ())) {
        guard let citiesURL = citiesURL else { return }
        do {
            let data = try Data(contentsOf: citiesURL)
            let jsonData = try JSONDecoder().decode([City].self, from: data)
            completion(jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }
}
