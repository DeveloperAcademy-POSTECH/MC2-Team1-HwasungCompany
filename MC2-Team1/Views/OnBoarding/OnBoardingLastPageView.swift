//
//  OnBoardingLastPageView.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/06/14.
//

import SwiftUI

struct OnBoardingLastPageView: View {
    
    // Param
    @Binding var isFirstLaunching: Bool

    var body: some View {
        VStack{
            Button{
                isFirstLaunching.toggle()
            } label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 100))
                    .foregroundColor(Color.fontColor)
                    .padding(.bottom, 30)
            }
            Text("화살표를 클릭해서\n게임을 시작하세요.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
        }
    }
}
