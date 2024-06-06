//
//  FavouritesViewModel.swift
//  WeatherApp
//
//  Created by Sheheryar Ahmed on 06/06/2024.
//

import Foundation
import CoreData

class FavouritesViewModel: ObservableObject {
    @Published var favouriteCities: [City] = []
    
    private let context = PersistenceController.shared.container.viewContext
    
    func fetchFavourites() {
        let request: NSFetchRequest<City> = City.fetchRequest()
        
        do {
            favouriteCities = try context.fetch(request)
        } catch {
            print("Failed to fetch cities: \(error.localizedDescription)")
        }
    }
    
    func addFavourite(city: String) {
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
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}
