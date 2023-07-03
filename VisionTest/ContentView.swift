//
//  ContentView.swift
//  VisionTest
//
//  Created by Zachary Farmer on 5/19/23.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    
    @EnvironmentObject var vm: AppViewModel
    @State private var showingSheet = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        switch vm.dataScannerAccessStatus {
        case .scannerAvailable:
            mainView
        case .cameraNotAvailable:
            Text("Your device doesn't have a camera")
        case .scannerNotAvailable:
            Text("Your device doesn't have support for scanning data with this app")
        case .cameraAccessNotGranted:
            Text("Please provide access to the camera in settings")
        case .notDetermined:
            Text("Requesting camera access")
            
        }
    }
    
    private var mainView: some View {
        VStack {
//            if (vm.isShown) {
//                }
                Button("Show Sheet") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    SheetView()
                }
            
            VStack {
                headerView
                
                //Put into it's own view at some point
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(vm.recognizedItems) { item in
                            switch item {
                            case .barcode(let barcode):
                                Text(barcode.payloadStringValue ?? "Unknown barcode")
                                
                            case .text(let text):
                                Text(text.transcript)
                                
                                
                                
                            @unknown default:
                                Text("Something wrong fam")
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onChange(of: vm.recognizesMultipleItems) { _ in vm.recognizedItems = [] }
    }
    
    private var headerView: some View {
        VStack {
            Text(vm.headerText).padding(.top)
        }
        .padding(.horizontal)
    }
    
}

struct SheetView: View {
    @EnvironmentObject var vm: AppViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
                DataScannerView(isShown: $vm.isShown, recognizedItems: $vm.recognizedItems,
                                recongizedDataType: vm.recognizedDataType,
                                recognizesMultipleItems: vm.recognizesMultipleItems)
                .ignoresSafeArea()
                .id(vm.dataScannerViewId)
            
            headerView
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(vm.recognizedItems) { item in
                        switch item {
                        case .barcode(let barcode):
                            Text(barcode.payloadStringValue ?? "Unknown barcode")
                            
                        case .text(let text):
                            Text(text.transcript)
                            
                            
                            
                        @unknown default:
                            Text("Something wrong fam")
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 200)
            
            Button("Press to dismiss") {
                dismiss()
            }
        }
    }
    private var headerView: some View {
        VStack {
            HStack {
                Text("Scan Multiple")
                Toggle("", isOn: $vm.recognizesMultipleItems)
                    .padding(.trailing, 200)
            }
            Text(vm.headerText).padding(.top)
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
