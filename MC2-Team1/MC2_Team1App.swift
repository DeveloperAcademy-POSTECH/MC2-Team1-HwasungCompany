//
//  MC2_Team1App.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/05/23.
//

import SwiftUI

@main
struct MC2_Team1App: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
//            StartView()
                .environmentObject(modelData)
        }
    }
}
