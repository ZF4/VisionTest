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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .task {
                    await vm.requestDataScannerAccessStatus()
                }
        }
    }
}
