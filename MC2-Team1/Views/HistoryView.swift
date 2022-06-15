//
//  HistoryView.swift
//  MC2-Team1
//
//  Created by peo on 2022/06/09.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var modelData: ModelData
    @State var lastSize: CGFloat = 0
    @State var recHeight: CGFloat = 0
    @AppStorage("fontSize") var fontSize: Double = 18
    @AppStorage("paragraphId") var paragraphId: Int = 1
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { proxy in
                LazyVStack(spacing: 0) {
                    ForEach(0..<modelData.pastParas.count + 1, id: \.self) { index in
                        if index < modelData.pastParas.count {
                            // Show history paragraphs & choices
                            VStack {
                                Group {
                                    Text(modelData.pastParas[index][0])
                                        .padding(.vertical, index == 0 ? RatioSize.getResheight(height: 10) : RatioSize.getResheight(height: 15))
                                        .font(.custom("NanumMyeongjo", size: index == 0 ? fontSize + 4 : fontSize))
                                        .frame(
                                            maxWidth: UIScreen.main.bounds.width,
                                            alignment: index == 0 ? .center : .leading
                                        )
                                    
                                    // with choice
                                    if modelData.pastParas[index].count == 2 {
                                        Text(modelData.pastParas[index][1])
                                            .frame(
                                                maxWidth: UIScreen.main.bounds.width,
                                                alignment: .center
                                            )
                                            .foregroundColor(.fontColor)
                                            .font(.custom("NanumMyeongjoBold", size: 18))
                                            .frame(maxWidth: .infinity, maxHeight: RatioSize.getResheight(height: 60))
                                            .padding(.vertical, RatioSize.getResheight(height: 15))
                                            .background(Color.bgColor)
                                            .cornerRadius(50)
                                            .shadow(color: Color("ButtonShadow"), radius: 3, x: 0, y: 0)
                                            .padding(.horizontal)
                                            .padding(.vertical, RatioSize.getResheight(height: 5))
                                    }
                                }
                                .font(.custom("NanumMyeongjo", size: fontSize))
                                .lineLimit(nil)
                                .lineSpacing(fontSize - 6)
                            }
                        } else { // Show current paragraph
                            Rectangle()
                                .fill(Color.bgColor)
                                .frame(
                                    width: UIScreen.main.bounds.width,
                                    height: (UIScreen.main.bounds.height - RatioSize.getResheight(height: 180 + recHeight)) / 2.0
                                )
                                .onAppear {
                                    recHeight = lastSize
                                }
                                .onChange(of: lastSize) { value in
                                    recHeight = value
                                }
                            
                            FadeInView(
                                text: modelData.filterPara(currentChapter: modelData.currentChapterIndex, id: paragraphId).content,
                                fontSize: fontSize
                            )
                            .frame(
                                maxWidth: UIScreen.main.bounds.width,
                                alignment: .leading
                            )
                            .padding(.vertical, fontSize + 6)
                            .background(ViewGeometry())
                            .onPreferenceChange(ViewSizeKey.self) {
                                lastSize = $0.height
                            }
                        }
                    }
                    
                    Rectangle()
                        .fill(Color.bgColor)
                        .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - RatioSize.getResheight(height: 230 + recHeight)) / 2.0)
                        .onAppear {
                            recHeight = lastSize
                        }
                        .onChange(of: lastSize) { value in
                            recHeight = value
                        }
                }
                .onChange(of: modelData.lastPastParaIndex) { value in
                    proxy.scrollTo(value, anchor: .top)
                }
                .onAppear {
                    modelData.lastPastParaIndex = modelData.pastParas.count
                    proxy.scrollTo(modelData.lastPastParaIndex, anchor: .top)
                }
            }
        }
        .padding(.top, 1)
    }
}

struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}
