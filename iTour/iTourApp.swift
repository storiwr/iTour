//
//  iTourApp.swift
//  iTour
//
//  Created by Stephen on 11/5/23.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self) //step 3 in swift data adding
    }
}
