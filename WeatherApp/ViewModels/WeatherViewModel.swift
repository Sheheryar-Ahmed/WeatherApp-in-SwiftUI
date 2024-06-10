//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Sheheryar Ahmed on 06/06/2024.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var city: String = ""
    @Published var errorMessage: String?
    @Published var currentLocation: CLLocation?
    
    private let weatherService = WeatherService()
    private let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    private let favouritesViewModel = FavouritesViewModel()

    init() {
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.currentLocation = location
                self?.fetchWeather(for: location)
            }
            .store(in: &cancellables)
    }
    
    func fetchWeather(for city: String) {
        weatherService.fetchWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { weather in
                self.weather = weather
                self.errorMessage = nil
            }).store(in: &cancellables)
    }
    
    func fetchWeather(for location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        weatherService.fetchWeather(forLatitude: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { weather in
                self.weather = weather
                self.errorMessage = nil
                self.city = weather.name
            }).store(in: &cancellables)
    }
    
    func addFavouriteCity() {
        if !city.isEmpty {
            favouritesViewModel.addFavourite(city: city)
        }
    }
}
