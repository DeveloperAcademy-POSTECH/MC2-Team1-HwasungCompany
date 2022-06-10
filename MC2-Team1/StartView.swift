//
//  StartView.swift
//  MC2-Team1
//
//  Created by peo on 2022/06/09.
//

import SwiftUI

struct StartView: View {
    @State private var tapFontColorOpacity = true
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.bgColor
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                Group{
                    Text("NIPS")
                        .font(.custom("NuosuSIL-Regular", size: 96))
                        .foregroundColor(.fontColor)
                        .padding(.leading, 50)
                    
                    HStack {
                        Spacer()
                        Text("Hydden")
                            .font(.custom("NuosuSIL-Regular", size: 60))
                            .foregroundColor(.fontColor)
                            .padding(.trailing, 50)
                    }
                }
                .padding(.horizontal)
                
                ZStack {
                    HStack {
                        Rectangle()
                            .fill(Color.fontColor)
                            .frame(maxWidth: CGFloat(3 * (50 + 17) + 50), maxHeight: 2)
                        Rectangle()
                            .fill(Color.pastColor)
                            .frame(maxWidth: UIScreen.main.bounds.width - CGFloat(3 * (50 + 17) + 50), maxHeight: 2)
                    }
                    
                    HStack(alignment: .center, spacing: 50) {
                        Spacer()
                        ForEach(0..<6, id: \.self) { index in
                            DotView(circleIndex: index, chapterIndex: 3)
                        }
                        Spacer()
                    }
                }
                .padding(.top, 160)
                
                HStack {
                    Spacer()
                    Text("Chapter 1")
                        .font(.custom("NuosuSIL-Regular", size: 24))
                        .foregroundColor(.fontColor)
                        .padding(.top, 30)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text("\"낯선 방\"")
                        .font(.custom("NotoSerifKR-Regular", size: 20))
                        .foregroundColor(.fontColor)
                    Spacer()
                }
                .padding(.top, 10)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("탭해서 시작하기")
                        .font(.custom("Inter-SemiBold", size: 20))
                        .foregroundColor(.tapFontColor)
                        .opacity(tapFontColorOpacity ? 1 : 0)
                        .animation(.linear(duration: 1).repeatForever(), value: tapFontColorOpacity)
                        .onAppear {
                            tapFontColorOpacity.toggle()
                        }
                    Spacer()
                }
                .padding(.bottom, 60)
            }
            .padding(.top, 120)
        }
    }
}
