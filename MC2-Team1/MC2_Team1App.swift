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
//            GlassAnimationView()
                .environmentObject(modelData)
        }
    }
}

struct DemoScrollViewOffsetView: View {
    @State private var offset = CGFloat.zero
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<100) { i in
                    Text("Item \(i)").padding()
                }
            }
            .background(
                GeometryReader {
                    Color.clear.preference(
                        key: ViewOffsetKey.self,
                        value: -$0.frame(in: .named("scroll")).origin.y
                    )
            })
            .onPreferenceChange(ViewOffsetKey.self) { print("offset >> \($0)") }
        }.coordinateSpace(name: "scroll")
    }
}
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
    
}
