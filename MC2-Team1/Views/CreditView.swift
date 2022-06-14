//
//  CreditView.swift
//  MC2-Team1
//
//  Created by Shin yongjun on 2022/06/14.
//

import SwiftUI

struct CreditView: View {
    @State private var animationStart = false
    @State private var animationEnd = false
    // animation 지속시간
    private let startAnimationDuration = 5.0
    private let middleAnimationDuration = 7.0
    private let endAnimationDuration = 0.5
    private let mainFont = "NanumMyeongjo"
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var opacity: Double = 0
    
    var body: some View {
        ZStack {
            Image("EndCreditBackgroud-1")
                .resizable()
            Text("Hello Woody! \nHello Digi! \nHello Bethev! \nHello EllyJ! \nHello Rang! \nHello Sophie! \nHello Everett! \n\n\n\n Thank you")
                .fontWeight(.bold)
                .font(.custom(mainFont, size: 35))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .truncationMode(.head)
                .lineSpacing(10)
                .padding()
            
            
                .rotation3DEffect(.degrees(animationEnd ? 0 : 35), axis: (x: 1, y: 0, z: 0))
                .shadow(color: .gray, radius: 3, x: 0, y: 10)
                .frame(width: 400, height: animationStart ? 750 : 0)
                //.animation(Animation.linear(duration: startAnimationDuration), value: opacity)
                .animation(Animation.linear(duration: animationEnd ? endAnimationDuration : startAnimationDuration))
                .onAppear() {
                    self.animationStart.toggle()
                    opacity = 1
                    // animation 시간 후 animationEnd true
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.middleAnimationDuration) {
                            self.animationEnd.toggle()
                        
                    }
            }
        }
        .ignoresSafeArea()
        
    }
}

struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}
