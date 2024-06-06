//
//  FavouritesView.swift
//  WeatherApp
//
//  Created by Sheheryar Ahmed on 06/06/2024.
//

import SwiftUI

struct FavouritesView: View {
    @StateObject private var viewModel = FavouritesViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.favouriteCities) { city in
                Text(city.name ?? "Unknown City")
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let city = viewModel.favouriteCities[index]
                    viewModel.removeFavourite(city: city)
                }
            }
        }
        .navigationTitle("Favourite Cities")
        .onAppear {
            viewModel.fetchFavourites()
        }
    }
}
