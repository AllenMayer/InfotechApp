//
//  WeatherManager.swift
//  InfotechApp
//
//  Created by Максим Семений on 18.08.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

final class WeatherManager {
    static let shared = WeatherManager()
    private let API_KEY = "03d98141bc10196b27b61c2221b410a1"
    
    func getWeather(cityId: Int, completion: @escaping((_ weather: WeatherInfo) -> ())) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(API_KEY)&units=metric") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil, let data = data else { return }
            
            do {
                let jsonData = try JSONDecoder().decode(WeatherInfo.self, from: data)
                completion(jsonData)
            } catch {
                print(error)
            }
        }.resume()
    }
}
