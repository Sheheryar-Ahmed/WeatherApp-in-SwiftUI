//
//  ContentView.swift
//  WeatherApp
//
//  Created by Sheheryar Ahmed on 05/06/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter city", text: $viewModel.city)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Get Weather") {
                    viewModel.fetchWeather(for: viewModel.city)
                }
                .padding()
                
                if let weather = viewModel.weather {
                    VStack {
                        Text("Weather in \(weather.name)")
                            .font(.largeTitle)
                        Text("\(weather.main.temp, specifier: "%.1f") °C")
                            .font(.title)
                        Text(weather.weather.first?.description ?? "")
                    }
                    .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                NavigationLink(destination: FavouritesView()) {
                    Text("Go to Favourites")
                }
                .padding()
            }
            .navigationTitle("Weather App")
        }
        .onAppear {
            if let location = viewModel.currentLocation {
                viewModel.fetchWeather(for: location)
            }
        }
    }
}


#Preview {
    ContentView()
}
