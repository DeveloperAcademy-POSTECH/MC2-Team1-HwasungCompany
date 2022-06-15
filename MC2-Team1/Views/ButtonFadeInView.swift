//
//  ButtonFadeInView.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/06/12.
//

import SwiftUI

struct ButtonFadeInView: View {
    @Binding var mode: Mode
    
    // param
    let choice: Choice
    let content: String
    
    // define
    @EnvironmentObject var modelData: ModelData
    @AppStorage("paragraphId") var paragraphId: Int = 1
    @AppStorage("Bfriendship") var Bfriendship: Int = 0
    @AppStorage("Cfriendship") var Cfriendship: Int = 0
    // MiniGame
    @AppStorage("isGlassGame") var isGlassGame: Bool = false
    @AppStorage("isPullLeverGame") var isPullLeverGame: Bool = false
    @AppStorage("isBoxOpenGame") var isBoxOpenGame: Bool = false
    @State var opacity: Double = 0
    @Binding var isButtonHidden: Bool
    
    var currentParagraph: Paragraph {modelData.filterPara(currentChapter: modelData.currentChapterIndex, id: paragraphId)}
    private let mainFontBold = "NanumMyeongjoBold"

    var body: some View {
        
        Group{
            if isButtonHidden {
                buttonViewBuilder()
                    .hidden()
            } else {
                buttonViewBuilder()
                   .opacity(opacity)
                   .animation(.easeIn.delay( 0.1 ), value: opacity)
                   .onAppear {
                       DispatchQueue.main.asyncAfter(deadline: .now()){
                           opacity = 1
                       }
                   }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + getDelayTime()) {
                self.isButtonHidden = false
            }
        }
    }
}

extension ButtonFadeInView{
    func getDelayTime() -> Double {
        let length = Double(content.count)
        var delayTime = 0.0
        
        delayTime = length * 0.03

        return delayTime
    }
}

// View Builder Extension
extension ButtonFadeInView{
    @ViewBuilder func buttonViewBuilder() -> some View {
        Button{
            self.isButtonHidden = true
            // go to next chapter, need to show bridge view
            if choice.nextParagraphId == -1 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
                    modelData.currentChapterIndex = choice.nextChapterIndex!
                    modelData.pastParas = [["기록들"]]
                    paragraphId = 1
                }
                withAnimation(.linear(duration: 0.4)) {
                    modelData.bridgeChapterIndex = choice.nextChapterIndex!
                    mode = .bridge
                }
            // 호감도에 따른 갈림길
            } else if choice.nextParagraphId == -2 {
                print(Bfriendship)
                if Bfriendship <= 10 {
                    print("under 10")
                    paragraphId = 1001
                } else {
                    print("over 10")
                    paragraphId = 2001
                }
            } else {
                // show next paragraph
                // now save when existing one choice
                if currentParagraph.choices?.count == 1 {
                    modelData.pastParas.append([currentParagraph.content])
                } else if currentParagraph.choices?.count == 2 {
                    modelData.pastParas.append([currentParagraph.content, choice.content])
                }
                paragraphId = choice.nextParagraphId
                if let effectB = choice.effectB {
                    withAnimation(.linear) {
                        Bfriendship += effectB
                    }
                }
                if let effectC = choice.effectC {
                    withAnimation(.linear) {
                        Cfriendship += effectC
                    }
                }
                if let gameName = currentParagraph.game {
                    switch gameName {
                    case "GlassAnimation":
                        isGlassGame = true
                    case "PullLeverGame":
                        isPullLeverGame = true
                    case "BoxOpen":
                        isBoxOpenGame = true
                    default:
                        break
                    }
                }
            }
        } label: {
            Text(choice.content)
                .foregroundColor(.fontColor)
                .font(.custom(mainFontBold, size: 18))
                .frame(maxWidth: .infinity, maxHeight: RatioSize.getResheight(height: 60))
                .background(Color.bgColor)
                .cornerRadius(50)
                .shadow(color: Color("ButtonShadow"), radius: 3, x: 0, y: 0)
                .padding(.horizontal)
                .padding(.vertical, RatioSize.getResheight(height: 5))
        }
    }
}
