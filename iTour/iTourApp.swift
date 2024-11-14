//
//  iTourApp.swift
//  iTour
//
//  Created by David Malicke on 11/12/24.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
