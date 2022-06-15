//
//  NextChapterView.swift
//  MC2-Team1
//
//  Created by peo on 2022/06/11.
//

import SwiftUI

struct BridgeView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var tapFontColorOpacity = true
    @Binding var mode: Mode
    
    private let textWidth = width * 0.88
    private let textPadding = width * 0.12
    
    @State private var chapterNumber = "1"
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.bgColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Spacer()
                
                ZStack {
                    HStack {
                        Rectangle()
                            .fill(Color.fontColor)
                            .frame(maxWidth: CGFloat(CGFloat(modelData.bridgeDotIndex) * RatioSize.getResWidth(width: 67) + RatioSize.getResWidth(width: 35)), maxHeight: 2)
                        Rectangle()
                            .fill(Color.pastColor)
                            .frame(maxWidth: UIScreen.main.bounds.width - CGFloat(CGFloat(modelData.bridgeDotIndex) * RatioSize.getResWidth(width: 67) + RatioSize.getResWidth(width: 35)), maxHeight: 2)
                    }
                    
                    HStack(alignment: .center, spacing: RatioSize.getResWidth(width: 50)) {
                        Spacer()
                        ForEach(0..<6, id: \.self) { index in
                            DotView(circleIndex: index, chapterIndex: modelData.bridgeDotIndex)
                        }
                        Spacer()
                    }
                }
                
                HStack {
                    Spacer()
                    Text("Chapter \(chapterNumber)")
                        .font(.custom("NuosuSIL-Regular", size: RatioSize.getResWidth(width: 24)))
                        .foregroundColor(.fontColor)
                        .padding(.top, RatioSize.getResheight(height: 30))
                        .onAppear {
                            switch modelData.bridgeChapterIndex {
                            case 0:
                                chapterNumber = "1"
                            case 1:
                                chapterNumber = "2"
                            case 2:
                                chapterNumber = "3"
                            case 3:
                                chapterNumber = "4"
                            case 4:
                                chapterNumber = "5"
                            case 5:
                                chapterNumber = "6-B"
                            case 6:
                                chapterNumber = "6-C"
                            default :
                                chapterNumber = ""
                            }
                        }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text("\(modelData.chapterNameArray[modelData.bridgeChapterIndex])")
                        .font(.custom("NotoSerifKR-Regular", size: RatioSize.getResWidth(width: 20)))
                        .foregroundColor(.fontColor)
                    Spacer()
                }
                .padding(.top, RatioSize.getResheight(height: 10))
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("탭해서 시작하기")
                        .font(.custom("Inter-SemiBold", size: RatioSize.getResWidth(width: 20)))
                        .foregroundColor(.tapFontColor)
                        .opacity(tapFontColorOpacity ? 1 : 0)
                        .animation(.linear(duration: 1).repeatForever(), value: tapFontColorOpacity)
                        .onAppear {
                            tapFontColorOpacity.toggle()
                        }
                    Spacer()
                }
                .padding(.bottom, RatioSize.getResheight(height: 60))
            }
            .padding(.top, RatioSize.getResheight(height: 120))
        }
    }
}
