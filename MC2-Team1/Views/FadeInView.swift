//
//  FadeInView.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/05/31.
//

import SwiftUI

struct FadeInView: View {
    
    // Param
    var text: String
    var fontSize: CGFloat
    
    // Define
    @AppStorage("isTextAnimation") var isTextAnimation: Bool = true
    @State var opacity: Double = 0
    @EnvironmentObject var modelData: ModelData
    
    // body
    var body: some View {
        Text(text)
            .font(.custom(modelData.getContentFontName(), size: fontSize))
            .opacity( isTextAnimation == true ? opacity : Double(1))
            .lineSpacing(fontSize - 6)
            .animation(.easeIn.delay( 0.3 ), value: opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    opacity = 1
                }
            }
    }
    
}
