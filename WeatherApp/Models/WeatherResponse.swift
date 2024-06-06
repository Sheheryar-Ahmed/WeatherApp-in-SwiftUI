//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Sheheryar Ahmed on 06/06/2024.
//

import Foundation

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
    let icon: String
}
