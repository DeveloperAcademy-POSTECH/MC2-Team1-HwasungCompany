//
//  SettingButtonView.swift
//  MC2-Team1
//
//  Created by Seulki Lee on 2022/06/10.
//

import SwiftUI
import PartialSheet

struct SettingButtonView: View {
    @State private var isSheetPresented = false

    var body: some View {
        HStack {
            Spacer()
            PSButton(
                isPresenting: $isSheetPresented,
                label: {
                    Text("Settings")
                })
                .padding()
            Spacer()
        }
        .partialSheet(isPresented: $isSheetPresented,
                      content: SettingView.init)
    }
}

struct SettingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        SettingButtonView()
        }
        .attachPartialSheetToRoot()
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
