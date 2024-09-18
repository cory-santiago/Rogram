//
//  RogramApp.swift
//  Rogram
//
//  Created by Cory Santiago on 9/16/24.
//

import RogramAPI
import SwiftUI

@main
struct RogramApp: App {
    // - MARK: Dependencies
    let apiDependency = RogramNetworking()

    var body: some Scene {
        WindowGroup {
            ContentView(api: apiDependency)
        }
    }
}
