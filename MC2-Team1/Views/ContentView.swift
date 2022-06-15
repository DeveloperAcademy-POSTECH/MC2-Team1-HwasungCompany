//
//  ContentView.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/05/23.
//

import SwiftUI

struct ContentView: View {
    // Param
    @Binding var mode: Mode
    
    // Define
    @EnvironmentObject var modelData: ModelData
    
    @AppStorage("paragraphId") var paragraphId: Int = 1
    @AppStorage("fontSize") var fontSize: Double = 18
    @AppStorage("isTextAnimation") var isTextAnimation: Bool = true
    @AppStorage("Bfriendship") var Bfriendship: Int = 0
    @AppStorage("Cfriendship") var Cfriendship: Int = 0
    // MiniGame
    @AppStorage("isGlassGame") var isGlassGame = false
    @AppStorage("isPullLeverGame") var isPullLeverGame = false
    @AppStorage("isBoxOpenGame") var isBoxOpenGame = false
    
    @State var isShowing = false
    @State var isShowingAlert = false
    
    var currentParagraph: Paragraph {modelData.filterPara(currentChapter: modelData.currentChapterIndex, id: paragraphId)}
    
    private let mainFont = "NanumMyeongjo"
    
    // body
    var body: some View {
        ZStack{
            
            // Background
            Color.bgColor
                .ignoresSafeArea()
            
            VStack{
                
                // Tool Bar
                toolbarViewBuilder().padding(.top)
                
                // Content && History
                HistoryView()
                    .padding(.horizontal, RatioSize.getResWidth(width: 20))
                    .padding(.top, RatioSize.getResheight(height: 5))
                
                // Choice Buttons
                // TODO: 버튼 최하단에 padding 넣어야 함
                ButtonViewBuilder().padding(.bottom)
            }
            
            // Setting Sheet
            HalfASheet(isPresented: $isShowing){
                settingViewBuilder()
            }
            .height(.proportional(0.4))
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $isGlassGame) {
            GlassAnimationView()
        }
        .fullScreenCover(isPresented: $isPullLeverGame) {
            PullLeverGameView()
        }
        .fullScreenCover(isPresented: $isBoxOpenGame) {
            BoxOpenView()
        }
    }
}

// ViewBuilder Extension
extension ContentView {
    
    // FadeInViewReloader
    @ViewBuilder func FadeInViewReloader(text: String, fontSize: CGFloat) -> some View {
        FadeInView(text: text, fontSize: fontSize, isTextAnimation: isTextAnimation)
    }
    
    // ButtonViewReloader
    @ViewBuilder func ButtonViewBuilder() -> some View {
        Group {
            
            if currentParagraph.hasChoices {
                Group {
                    VStack {
                        ForEach(currentParagraph.choices ?? [], id: \.self) {choice in
                            ButtonFadeInView(mode: $mode, choice: choice, content: currentParagraph.content)
                        }
                    }
                }
                .background(ViewGeometry())
            }
            
        }
        .padding(.horizontal)
    }
    
    // Toolbar ViewBuilder
    @ViewBuilder func toolbarViewBuilder() ->  some View{
        ZStack{
            // Friendship Indicator
            ZStack{
                ZStack{
                    Divider()
                        .frame(height: RatioSize.getResheight(height: 1))
                        .overlay(Color.fontColor)
                    HStack{
                        Divider()
                            .frame(width: RatioSize.getResWidth(width: 1), height: RatioSize.getResheight(height: 5))
                            .overlay(Color.fontColor)
                    }
                }
                HStack{
                    Text((modelData.currentChapterIndex == 1 && paragraphId >= 7) || modelData.currentChapterIndex > 1 ? "백":"?")
                        .font(.custom(mainFont, size: RatioSize.getResWidth(width: 18)))
                        .foregroundColor(.fontColor)
                        .frame(width: RatioSize.getResWidth(width: 30), height: RatioSize.getResWidth(width: 30))
                        .background(Color.tapFontColor)
                        .cornerRadius(50)
                    
                    Spacer()
                    
                    Text((modelData.currentChapterIndex == 2 && paragraphId >= 14) || modelData.currentChapterIndex > 2 ? "최":"?")
                        .font(.custom(mainFont, size: RatioSize.getResWidth(width: 18)))
                        .foregroundColor(.fontColor)
                        .frame(width: RatioSize.getResWidth(width: 30), height: RatioSize.getResWidth(width: 30))
                        .background(Color.tapFontColor)
                        .cornerRadius(50)
                }//HStack
                
                Text("나")
                    .font(.custom(mainFont, size: RatioSize.getResWidth(width: 18)))
                    .foregroundColor(.fontColor)
                    .frame(width: RatioSize.getResWidth(width: 30), height: RatioSize.getResWidth(width: 30))
                    .background(Color.bgColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.tapFontColor, lineWidth: 1)
                    )
                    .offset(x: getFriendshipDistance())
            }
            .frame(width: RatioSize.getResWidth(width: 230))
            // Gear Icon
            HStack{
                Spacer()
                Button(){
                    isShowing.toggle()
                }label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: RatioSize.getResWidth(width: 20), height: RatioSize.getResWidth(width: 20))
                        .foregroundColor(.fontColor)
                }
                .padding()
            }
        }
        .frame(height: RatioSize.getResheight(height: 40))
    }
    
    // Setting View Builder
    @ViewBuilder func settingViewBuilder() -> some View {
        VStack(alignment: .leading, spacing: RatioSize.getResWidth(width: 20)){
            // Title
            HStack{
                Spacer()
                Text("설정")
                    .font(.system(size: RatioSize.getResWidth(width: 22)))
                Spacer()
            }
            
            // Text Animation Toggle
            HStack{
                Toggle(isOn: $isTextAnimation) {
                    Text("텍스트 애니메이션 효과")
                }
            }
            
            // Text Size Adjust
            Text("텍스트 크기")

            VStack{
                // Sample Text
                Text("현재 텍스트 크기 입니다.")
                    .font(.system(size: fontSize))
                    .padding(.vertical, RatioSize.getResheight(height: 10))
                    .frame(height: 30)
                
                // Slider
                HStack{
                    Text("가")
                        .font(.system(size: 14))
                    Slider(value: $fontSize, in: 14...22,
                           step: 2)
                    Text("가")
                        .font(.system(size: 22))
                }
                .padding(.vertical, RatioSize.getResheight(height: 10))
            }
            .padding()
            .background(Color.tapFontColor.opacity(0.5))
            .cornerRadius(15)
            .offset(y: -10)
            
            // Game Reset Button
            HStack{
                Button{
                    isShowingAlert = true
                }label: {
                    Text("게임 초기화 하기")
                }
                .alert(isPresented: $isShowingAlert){
                    
                    Alert(
                        title: Text("초기화 하시겠습니까?"),
                        message: Text("게임의 진행도가 초기화 됩니다. \n이행동은 되돌릴 수 없습니다."),
                        primaryButton: .default(Text("취소")),
                        secondaryButton: .destructive(Text("확인")){
                            // Clear history
                            modelData.currentChapterIndex = 0
                            modelData.pastParas = [["기록들"]]
                            withAnimation {
                                mode = .start
                            }
                            paragraphId = 1
                            fontSize = 18
                            isTextAnimation = true
                            Bfriendship = 0
                            Cfriendship = 0
                        }
                    )
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, RatioSize.getResheight(height: 10))
        
    }
}

// function Extension
extension ContentView {
    func getFriendshipDistance() -> CGFloat{
        var result = CGFloat(0)
        
        if Bfriendship == Cfriendship {
            result = CGFloat(0)
        } else if Bfriendship > Cfriendship {
            let sum = Bfriendship - Cfriendship
            result = CGFloat(Double(sum) * -2.8)
            if result < CGFloat(-25) {
                result = CGFloat(-25)
            }
        } else if Cfriendship > Bfriendship {
            let sum = Cfriendship - Bfriendship
            result = CGFloat(Double(sum) * 2.8)
            if result > CGFloat(25){
                result = CGFloat(25)
            }
        }
        return result
    }
}
