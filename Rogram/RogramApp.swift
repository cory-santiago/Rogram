//
//  RogramApp.swift
//  Rogram
//
//  Created by Cory Santiago on 9/16/24.
//

import RogramAPI
import SwiftUI
import SwiftData

@main
struct RogramApp: App {
    // - MARK: Dependencies
    let apiDependency = RogramNetworking()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(api: apiDependency)
        }
        .modelContainer(sharedModelContainer)
    }
}
