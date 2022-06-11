//
//  WaterAnimation.swift
//  MC2-Team1
//
//  Created by 황정현 on 2022/06/09.
//

import SwiftUI

struct GlassAnimationView: View {
    
    private let targetTouchCount = 5
    
    @State private var playerTouchCount: Int = 0
    @State private var waterTankBroken: Bool = false
    @State private var hurt: Bool = false

    @State private var positions: CGPoint = CGPoint(x:width * 0.5, y: height * 0.5)

    var body: some View {
        
        ZStack {
            ZStack {
                if (hurt == false) {
                    Image("Card")
                        .resizable()
                        .frame(width: width * 0.7, height: width * 0.7)
                        .foregroundColor(Color.red)
                } else {
                    Image("Card_Blood")
                        .resizable()
                        .frame(width: width * 0.7, height: width * 0.7)
                        .foregroundColor(Color.red)
                }
                if hurt {
                    ZStack {
                        //https://stackoverflow.com/questions/57342170/how-do-i-set-the-size-of-a-sf-symbol-in-swiftui
                        Image(systemName: "drop.fill")
                            .font(.system(size: 30, weight: .medium))
                            .foregroundColor(Color.blood)
                    }
                        .position(positions)
                        .onAppear {
                            withAnimation(.timingCurve(1,0.28,0.72,0.96, duration: 1.0)) {
                                positions.x = width * 0.5
                                positions.y = height * 1.1
                            }
                        }
                }
            }
            if (playerTouchCount < targetTouchCount - 1)
            {
                Image("Glass\(playerTouchCount)")
                    .resizable()
                    .frame(width: width, height: height, alignment: .center)
            }
        }.frame(width: width, height: height)
        .onTapGesture {
            playerTouchCount += 1
            if (playerTouchCount == targetTouchCount - 1) {
                HapticManager.haptic(type: .error)
                waterTankBroken = true
            } else if (playerTouchCount == targetTouchCount) {
                HapticManager.haptic(type: .success)
                hurt = true            } else if (playerTouchCount < targetTouchCount - 1){
                HapticManager.impact(style: .heavy)
            }
        }
    }
}

struct GlassAnimation_Previews: PreviewProvider {
    static var previews: some View {
        GlassAnimationView()
    }
}
