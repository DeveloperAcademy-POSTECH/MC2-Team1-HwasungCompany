//
//  ContentView.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/05/23.
//

import SwiftUI

struct ContentView: View {
    
    // Define
    @EnvironmentObject var modelData: ModelData
    @AppStorage("chapter") var chapter: String = "chapterOne"
    @AppStorage("paragraphId") var paragraphId: Int = 1
    @AppStorage("fontSize") var fontSize: Double = 18
    @AppStorage("isTextAnimation") var isTextAnimation: Bool = true
    @State var reloadTrigger = true
    @State var isShowing = false
    @State var isShowingAlert = false
    var currentParagraph: Paragraph {modelData.filterPara(chapter: chapter, id: paragraphId)}
    let NotoSerifMedium = "NotoSerifKR-Medium"
    
    // body
    var body: some View {
        ZStack{
            // Tool Bar
            VStack{
                ZStack{
                    // Friendship Indicator
                    ZStack{
                        ZStack{
                            Divider()
                                .frame(height: 1)
                                .overlay(Color.fontColor)
                            HStack{
                                Divider()
                                    .frame(width: 1, height: 5)
                                    .overlay(Color.fontColor)
                            }
                        }
                        HStack{
                            Text("백")
                                .font(.custom(NotoSerifMedium, size: 18))
                                .foregroundColor(.fontColor)
                                .frame(width: 30, height: 30)
                                .background(Color.tapFontColor)
                                .cornerRadius(50)
                            Spacer()
                            Text("최")
                                .font(.custom(NotoSerifMedium, size: 18))
                                .foregroundColor(.fontColor)
                                .frame(width: 30, height: 30)
                                .background(Color.tapFontColor)
                                .cornerRadius(50)
                        }
                        Text("나")
                            .font(.custom(NotoSerifMedium, size: 18))
                            .foregroundColor(.fontColor)
                            .frame(width: 30, height: 30)
                            .background(Color.bgColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.tapFontColor, lineWidth: 1)
                            )
                            .offset(x: 20)
                    }
                    .frame(width: 180)
                    // Gear Icon
                    HStack{
                        Spacer()
                        Button(){
                            isShowing.toggle()
                        }label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.fontColor)
                        }
                        .padding()
                    }
                }
                .frame(height: 60)
                Spacer()
            }
            
            // Content
            VStack {
                Spacer()
                FadeInViewReloader(text: currentParagraph.content, fontSize: fontSize)
                    .padding(.bottom, 110)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            // Choices
            VStack{
                Spacer()
                if currentParagraph.hasChoices {
                    ForEach(currentParagraph.choices!, id: \.self) {choice in
                        
                        Text(choice.content)
                            .foregroundColor(.fontColor)
                            .font(.custom(NotoSerifMedium, size: 18))
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .background(Color.bgColor)
                            .cornerRadius(50)
                            .shadow(color: .gray, radius: 2, x: 0, y: 0)
                            .onTapGesture {
                                paragraphId = choice.nextParagraphId
                                reloadTrigger.toggle()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                    }
                }
            }
            .padding(.horizontal, 20)
            
            // Setting Sheet
            HalfASheet(isPresented: $isShowing){
                settingViewBuilder()
            }
            .height(.proportional(0.6))
            .ignoresSafeArea()
        }
    }
}

// ViewBuilder Extension
extension ContentView {
    
    // FadeInOutViewReloader
    @ViewBuilder func FadeInByOrderViewReloader(text: String, fontSize: CGFloat) -> some View {
        if reloadTrigger {
            FadeInByOrderView(text: text, fontSize: fontSize, isTextAnimation: isTextAnimation)
        } else {
            FadeInByOrderView(text: text, fontSize: fontSize, isTextAnimation: isTextAnimation)
        }
    }
    
    // FadeInViewReloader
    @ViewBuilder func FadeInViewReloader(text: String, fontSize: CGFloat) -> some View {
        if reloadTrigger {
            FadeInView(text: text, fontSize: fontSize, isTextAnimation: isTextAnimation)
        } else {
            FadeInView(text: text, fontSize: fontSize, isTextAnimation: isTextAnimation)
        }
    }
    
    // Setting View Builder
    @ViewBuilder func settingViewBuilder() -> some View {
        VStack(alignment: .leading, spacing: 20){
            // Title
            HStack{
                Spacer()
                Text("설정")
                    .font(.system(size: 22))
                Spacer()
            }
            
            // Vibration Toggle
            HStack{
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    Text("진동 효과")
                }
            }
            
            // Text Animation Toggle
            HStack{
                Toggle(isOn: $isTextAnimation) {
                    Text("텍스트 애니메이션 효과")
                }
            }
            
            // Sound Effect Toggle
            HStack{
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    Text("사운드 효과")
                }
            }
            
            // Text Size Adjust
            HStack{
                Text("텍스트 크기")
            }
            
            VStack{
                // Sample Text
                Text("현재 텍스트 크기 입니다.")
                    .font(.system(size: fontSize))
                    .padding(.vertical, 10)
                    .frame(height: 30)
                
                // Slider
                HStack{
                    Text("가")
                        .font(.system(size: 12))
                    Slider(value: $fontSize, in: 12...24,
                           step: 2)
                    Text("가")
                        .font(.system(size: 24))
                }
                .padding(.vertical, 10)
            }
                        
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
                            // Reset Games
                        }
                    )
                }
                Spacer()
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .padding(.vertical, 10)

    }
}

// function Extension
extension ContentView {
    
}
