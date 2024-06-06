//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Sheheryar Ahmed on 06/06/2024.
//

import Foundation
import CoreData

extension City {
    @NSManaged public var weatherData: Data?
    
    var weather: WeatherResponse? {
        get {
            guard let weatherData = weatherData else { return nil }
            return try? JSONDecoder().decode(WeatherResponse.self, from: weatherData)
        }
        set {
            weatherData = try? JSONEncoder().encode(newValue)
        }
    }
}


struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
}
