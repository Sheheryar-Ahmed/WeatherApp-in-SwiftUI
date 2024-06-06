//
//  WeatherServices.swift
//  WeatherApp
//
//  Created by Sheheryar Ahmed on 06/06/2024.
//

import Foundation
import Combine

class WeatherService {
    private let apiKey = "15e0f927ee3398977ec8efa097047b7c"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error> {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError("Invalid city name")
        }
        
        let urlString = "\(baseUrl)?q=\(cityEncoded)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchWeather(forLatitude latitude: Double, longitude: Double) -> AnyPublisher<WeatherResponse, Error> {
        let urlString = "\(baseUrl)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
