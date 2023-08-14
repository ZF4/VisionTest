//
//  VisionTestApp.swift
//  VisionTest
//
//  Created by Zachary Farmer on 5/19/23.
//

import SwiftUI

@main
struct VisionTestApp: App {
    @StateObject private var vm = AppViewModel()
    @StateObject private var dataStore = DataStore()
    @State private var storedItem: StoredItem?
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .environmentObject(dataStore)
                .task {
                    await vm.requestDataScannerAccessStatus()
                }
        }
    }
}
