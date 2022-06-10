//
//  Blue.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/05/25.
//

import SwiftUI
import WrappingHStack

struct FadeInByOrderView: View {
    
    // Define
    var text: String
    var fontSize: CGFloat
    var isTextAnimation: Bool
    @State var opacity: Double = 0
    let NotoSerifMedium = "NotoSerifKR-Medium"

    // Body
    var body: some View {
        
        // Define
        let characters: Array<String.Element> = Array(text)
        
        WrappingHStack(
            0..<characters.count,
            spacing: .constant(1.2),
            lineSpacing: 3
        ) { index in
            Text(String(characters[index]))
                .font(.custom(NotoSerifMedium, size: fontSize))
                .opacity(opacity)
                .animation(.easeInOut.delay( Double(index) * 0.005 ), value: opacity)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()){
                opacity = 1
            }
        }
    }
}
