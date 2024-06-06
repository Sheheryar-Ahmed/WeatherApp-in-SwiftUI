//
//  FavouritesViewModel.swift
//  WeatherApp
//
//  Created by Sheheryar Ahmed on 06/06/2024.
//

import Combine
import CoreData
import Foundation

class FavouritesViewModel: ObservableObject {
    @Published var favouriteCities: [City] = []
    @Published var weatherData: [String: WeatherResponse] = [:]
    private let context = PersistenceController.shared.container.viewContext
    private let weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchFavourites() {
        let request: NSFetchRequest<City> = City.fetchRequest()
        do {
            favouriteCities = try context.fetch(request)
        } catch {
            print("Failed to fetch favorite cities: \(error.localizedDescription)")
        }
    }
    
    func addFavourite(city: String) {
        if favouriteCities.contains(where: { $0.name == city }) {
            print("City '\(city)' already exists in favourites.")
            return
        }
        
        let newCity = City(context: context)
        newCity.name = city
        
        saveContext()
    }
    
    func removeFavourite(city: City) {
        context.delete(city)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
            fetchFavourites()
        } catch {
            print("Failed to remove favorite city: \(error.localizedDescription)")
        }
    }
    
    func fetchWeather(for cityName: String) {
        weatherService.fetchWeather(for: cityName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Failed to fetch weather for \(cityName): \(error.localizedDescription)")
                }
            }, receiveValue: { weather in
                self.weatherData[cityName] = weather
                self.objectWillChange.send()
            })
            .store(in: &cancellables)
    }
}
