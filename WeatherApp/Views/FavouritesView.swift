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
                HStack {
                    VStack(alignment: .leading) {
                        Text(city.name ?? "Unknown City")
                            .font(.headline)
                        if let weather = viewModel.weatherData[city.name ?? ""] {
                            Text("Temp: \(weather.main.temp, specifier: "%.1f") °C")
                            Text("Humidity: \(weather.main.humidity)%")
                            Text("Condition: \(weather.weather.first?.description ?? "Unknown")")
                        } else {
                            Text("Loading weather data...")
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.removeFavourite(city: city)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical)
                .onAppear {
                    if let cityName = city.name {
                        viewModel.fetchWeather(for: cityName)
                    }
                }
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

#Preview {
    FavouritesView()
}
