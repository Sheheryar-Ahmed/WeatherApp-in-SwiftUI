//
//  HomeView.swift
//  WeatherApp
//
//  Created by Sheheryar Ahmed on 06/06/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        // SearchBar with error Views
        VStack {
            TextField("Enter city", text: $viewModel.city)
                
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.red)
            }
            
            //  Button Views
            HStack {
                Spacer()
                
                Button(action: {
                    viewModel.fetchWeather(for: viewModel.city)
                }) {
                    HStack {
                        Image(systemName: "cloud.fill")
                        Text("Get Weather")
                            .fontWeight(.bold)
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
                
                Button(action: {
                    viewModel.addFavouriteCity()
                }) {
                    Image(systemName: "star.fill")
                        .frame(width: 44, height: 44)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            .padding()
          
            // Weather Data Views
            if let weather = viewModel.weather {
                VStack {
                    Text("Weather in \(weather.name)")
                        .font(.largeTitle)
                    
                    HStack {
                        Text("Temperature:")
                        Text("\(weather.main.temp, specifier: "%.1f") °C")
                            .font(.title)
                    }
                    
                    HStack {
                        Text("Humidity:")
                        Text("\(weather.main.humidity)%")
                            .font(.title)
                    }
                    
                    HStack {
                        Text("Condition:")
                        Text(weather.weather.first?.description ?? "Unknown")
                            .font(.title)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(20)
                
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .navigationTitle("Weather App")
        .onAppear {
            if let location = viewModel.currentLocation {
                viewModel.fetchWeather(for: location)
            }
        }
    }
}

#Preview {
    HomeView()
}
