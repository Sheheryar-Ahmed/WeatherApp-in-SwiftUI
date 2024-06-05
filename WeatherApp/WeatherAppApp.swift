//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Sheheryar Ahmed on 05/06/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
