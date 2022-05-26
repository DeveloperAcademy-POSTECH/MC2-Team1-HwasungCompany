//
//  Blue.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/05/25.
//

import SwiftUI
import WrappingHStack

struct FadeInOutView: View {
    var text: String
    @State var startTime: Double
    @State var opacity: Double = 0
    let NotoSerifMedium = "NotoSerifKR-Medium"


    var body: some View {
        let characters: Array<String.Element> = Array(text)
        
        WrappingHStack(
            0..<characters.count,
            spacing: .constant(1.2),
            lineSpacing: 3
        ) { index in

            Text(String(characters[index]))
                .font(.custom(NotoSerifMedium, size: 18))
                .opacity(opacity)
                .animation(.easeInOut.delay( Double(index) * 0.01 ),
                           value: opacity)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + startTime){
                opacity = 1
            }
        }
    }
}
