//
//  NextChapterView.swift
//  MC2-Team1
//
//  Created by peo on 2022/06/11.
//

import SwiftUI

struct BridgeView: View {
    @Environment(\.colorScheme) var colorScheme
    
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
                
                switch chapterNumber {
                case "2":
                    Image(colorScheme == .light ? "백연우":"백연우_반전").resizable().frame(width: RatioSize.getResWidth(width: 250), height: RatioSize.getResWidth(width: 250)).scaledToFit()
                case "3":
                    Image(colorScheme == .light ? "최지원":"최지원_반전").resizable().frame(width: RatioSize.getResWidth(width: 250), height: RatioSize.getResWidth(width: 250)).scaledToFit()
                case "4":
                    Image(colorScheme == .light ? "치료제":"치료제_반전").resizable().frame(width: RatioSize.getResWidth(width: 250), height: RatioSize.getResWidth(width: 250)).scaledToFit()
                case "5":
                    Image(colorScheme == .light ? "갈림길":"갈림길_반전").resizable().frame(width: RatioSize.getResWidth(width: 250), height: RatioSize.getResWidth(width: 250)).scaledToFit()
                case "6":
                    Image(colorScheme == .light ? "안지민":"안지민_반전").resizable().frame(width: RatioSize.getResWidth(width: 250), height: RatioSize.getResWidth(width: 250)).scaledToFit()
                default:
                    EmptyView()
                }
               
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
                        .font(.custom(modelData.titleFontName, size: RatioSize.getResWidth(width: 24)))
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
                        .font(.custom(modelData.contentFontName, size: RatioSize.getResWidth(width: 20)))
                        .foregroundColor(.fontColor)
                    Spacer()
                }
                .padding(.top, RatioSize.getResheight(height: 10))
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("TAP TO START".localized())
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
