//
//  CreditView.swift
//  MC2-Team1
//
//  Created by Shin yongjun on 2022/06/14.
//
//https://www.appcoda.com/star-wars-animated-text-swiftui/

import SwiftUI
import AVFoundation


struct CreditView: View {
    @State private var animationStart = false
    @State private var animationEnd = false
    
    @State var audioPlayer: AVAudioPlayer!

    // animation 지속시간
    private let startAnimationDuration = 5.0
    private let middleAnimationDuration = 6.0
    private let endAnimationDuration = 0.5
    private let mainFont = "NanumMyeongjo"
    @State var attributedString = AttributedString("화성상사\n\n회장 Woody \n최고학력자 Digi \n영양사 Bethev \n충전 EllyJ \n글루건 Rang \n원어민 Sophie \n과장 Everett \n\n And you")
    @State var opacity: Double = 0
    
    var body: some View {
        ZStack {
            Image("EndCreditBackgroud")
                .resizable()
            Text(attributedString)
                .fontWeight(.bold)
                .font(.custom(mainFont, size: 35))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .truncationMode(.head)
                .lineSpacing(10)
                .padding()
            
            
                .rotation3DEffect(.degrees(animationEnd ? 0 : 35), axis: (x: 1, y: 0, z: 0))
                .shadow(color: .gray, radius: 4, x: 0, y: 2)
                .frame(width: 500, height: animationStart ? 750 : 0)
                //.animation(Animation.linear(duration: startAnimationDuration), value: opacity)
                .onAppear() {
                    let range = attributedString.range(of: "회장")!
                    attributedString[range].font = .custom(mainFont, size: 20)
                    let range1 = attributedString.range(of: "최고학력자")!
                    attributedString[range1].font = .custom(mainFont, size: 20)
                    let range2 = attributedString.range(of: "영양사")!
                    attributedString[range2].font = .custom(mainFont, size: 20)
                    let range3 = attributedString.range(of: "충전")!
                    attributedString[range3].font = .custom(mainFont, size: 20)
                    let range4 = attributedString.range(of: "글루건")!
                    attributedString[range4].font = .custom(mainFont, size: 20)
                    let range5 = attributedString.range(of: "원어민")!
                    attributedString[range5].font = .custom(mainFont, size: 20)
                    let range6 = attributedString.range(of: "과장")!
                    attributedString[range6].font = .custom(mainFont, size: 20)
                    
                    withAnimation(.linear(duration: animationEnd ? endAnimationDuration : startAnimationDuration)) {
                        self.animationStart.toggle()
                        opacity = 1
                    }
                    // animation 시간 후 animationEnd true
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.middleAnimationDuration) {
                        withAnimation {
                            self.animationEnd.toggle()
                        }
                    }
                    let sound = Bundle.main.path(forResource: "MyVeryOwnDeadShip", ofType: "mp3")
                    self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
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
