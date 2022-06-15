//
//  OnBoardingPageView.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/06/14.
//

import SwiftUI

struct OnBoardingPageView: View {
    
    // Param
    let pageNumber: Int 
    
    // Define
    @EnvironmentObject var modelData: ModelData
    let fontSize: Double = 18
    let paragraphId: Int = 1
    var currentParagraph: Paragraph {modelData.filterPara(currentChapter: modelData.currentChapterIndex, id: paragraphId)}
    private let content: String = "눈을 감고 호흡을 멈추자 물 속에 들어온 것처럼 모든 것이 멀어졌다.\n물소리… 어디선가 물소리가 들려.\n열린 문 틈 사이에서 들려오는 것 같아."
    
    // Font
    private let mainFont = "NanumMyeongjo"
    private let mainFontBold = "NanumMyeongjoBold"
    
    // Color
    private let shadowColor = Color.black.opacity(0.3)
    private let shadowRadius = CGFloat(1)
    private let shadowY = CGFloat(4)
    private let cornerRadius = CGFloat(5)

    var body: some View {
        ZStack{
            
            // Background
            Group{
                // Background
                Color.bgColor
            
                // Tool Bar
                VStack{
                    toolbarViewBuilder()
                    Spacer()
                }
                
                // Content && History
                VStack{
                    Spacer()
                    contentViewBuiler()
                        .padding(.horizontal)
                    Spacer()
                }
                
                // Choice Buttons
                VStack{
                    Spacer()
                    ButtonViewBuilder()
                }
            }
            
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            switch(pageNumber){
            case 2:
                pageTwoViewBuilder()
            case 3:
                pageThreeViewBuilder()
            case 4:
                pageFourViewBuilder()
            default:
                pageOneViewBuilder()
            }
            
        }
    }
}

// Custom ViewBuilder Extension
extension OnBoardingPageView{
    
    // Page One
    @ViewBuilder func pageOneViewBuilder() -> some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .frame(width: RatioSize.getResWidth(width: 20), height: RatioSize.getResheight(height: 20))
                    .padding(5)
                    .background(Color.bgColor)
                    .cornerRadius(cornerRadius)
                    .shadow(color: shadowColor, radius: shadowRadius, y: shadowY)
                    .foregroundColor(.fontColor)
                    .padding()
            }
            .frame(height: RatioSize.getResheight(height: 40))
            Spacer()
        }
        
        VStack{
            Text("화면 우측 상단에 있는 톱니바퀴를 눌러\n게임 설정을 변경할 수 있습니다.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.bgColor)
                .cornerRadius(5)
                .shadow(color: shadowColor, radius: shadowRadius, y: shadowY)
                .padding()
            Spacer()
        }
        .padding(.top, 120)
    }
    
    // Page Two
    @ViewBuilder func pageTwoViewBuilder() -> some View {
        
        // Button
        VStack{
            Spacer()
            VStack{
                Text("누군가가 있는걸까?")
                    .foregroundColor(.fontColor)
                    .font(.custom(mainFontBold, size: 18))
                    .frame(maxWidth: .infinity, maxHeight: RatioSize.getResheight(height: 60))
                    .background(Color.bgColor)
                    .cornerRadius(50)
                    .shadow(color: Color("ButtonShadow"), radius: 3, x: 0, y: 0)
                    .padding(.horizontal)
                    .padding(.vertical, RatioSize.getResheight(height: 5))
                    .padding(.top, 10)

                Text("문으로 가까이 다가간다")
                    .foregroundColor(.fontColor)
                    .font(.custom(mainFontBold, size: 18))
                    .frame(maxWidth: .infinity, maxHeight: RatioSize.getResheight(height: 60))
                    .background(Color.bgColor)
                    .cornerRadius(50)
                    .shadow(color: Color("ButtonShadow"), radius: 3, x: 0, y: 0)
                    .padding(.horizontal)
                    .padding(.vertical, RatioSize.getResheight(height: 5))
                    .padding(.bottom, 10)
            }
            .background(Color.bgColor)
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: shadowRadius, y: shadowY)
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        // Message
        VStack{
            Text("원하는 스토리를 터치하여\n스토리를 이어가세요.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.bgColor)
                .cornerRadius(5)
                .shadow(color: shadowColor, radius: shadowRadius, y: shadowY)
                .padding()
            Spacer()
        }
        .padding(.top, 120)
    }
    
    // Page Three
    @ViewBuilder func pageThreeViewBuilder() -> some View {
        // Arrow
        VStack{
            Image("arrow")
                .foregroundColor(Color.bgColor)
                .font(.system(size: 50))
                .shadow(color: shadowColor, radius: shadowRadius, y: shadowY)
                .padding(.top, 100)
            Spacer()

        }
        // Message
        VStack{
            Text("화면을 위에서 아래로 스크롤하여\n이전 스토리와 선택지를 확인할 수 있습니다.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.bgColor)
                .cornerRadius(5)
                .shadow(color: shadowColor, radius: shadowRadius, y: shadowY)
                .padding()
            Spacer()
        }
        .padding(.top, 460)
    }
    
    // Page Four
    @ViewBuilder func pageFourViewBuilder() -> some View {
        
        // Toolbar
        VStack{
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
                    Text("?")
                        .font(.custom(mainFont, size: RatioSize.getResWidth(width: 18)))
                        .foregroundColor(.fontColor)
                        .frame(width: RatioSize.getResWidth(width: 30), height: RatioSize.getResheight(height: 30))
                        .background(Color.tapFontColor)
                        .cornerRadius(50)
                    
                    Spacer()
                    
                    Text("?")
                        .font(.custom(mainFont, size: RatioSize.getResWidth(width: 18)))
                        .foregroundColor(.fontColor)
                        .frame(width: RatioSize.getResWidth(width: 30), height: RatioSize.getResheight(height: 30))
                        .background(Color.tapFontColor)
                        .cornerRadius(50)
                }//HStack
                
                Text("나")
                    .font(.custom(mainFont, size: RatioSize.getResWidth(width: 18)))
                    .foregroundColor(.fontColor)
                    .frame(width: RatioSize.getResWidth(width: 30), height: RatioSize.getResheight(height: 30))
                    .background(Color.bgColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.tapFontColor, lineWidth: 1)
                    )
                    .offset(x: -30)
            }
            .frame(width: RatioSize.getResWidth(width: 230))
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(Color.bgColor)
            .cornerRadius(5)
            .shadow(color: shadowColor, radius: shadowRadius, y: shadowY)
            .frame(height: RatioSize.getResheight(height: 40))
            Spacer()
        }
        // Message
        VStack{
            Text("선택지에 따라 인물의 호감도가 달라집니다.\n화면 상단에서 현재 호감도를 확인하세요.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.bgColor)
                .cornerRadius(5)
                .shadow(color: shadowColor, radius: shadowRadius, y: shadowY)
                .padding()
            Spacer()
        }
        .padding(.top, 120)
    }
}

// Base ViewBuilder Extension
extension OnBoardingPageView {
    
    // Toolbar
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
                    Text("?")
                        .font(.custom(mainFont, size: RatioSize.getResWidth(width: 18)))
                        .foregroundColor(.fontColor)
                        .frame(width: RatioSize.getResWidth(width: 30), height: RatioSize.getResheight(height: 30))
                        .background(Color.tapFontColor)
                        .cornerRadius(50)
                    
                    Spacer()
                    
                    Text("?")
                        .font(.custom(mainFont, size: RatioSize.getResWidth(width: 18)))
                        .foregroundColor(.fontColor)
                        .frame(width: RatioSize.getResWidth(width: 30), height: RatioSize.getResheight(height: 30))
                        .background(Color.tapFontColor)
                        .cornerRadius(50)
                }//HStack
                
                Text("나")
                    .font(.custom(mainFont, size: RatioSize.getResWidth(width: 18)))
                    .foregroundColor(.fontColor)
                    .frame(width: RatioSize.getResWidth(width: 30), height: RatioSize.getResheight(height: 30))
                    .background(Color.bgColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.tapFontColor, lineWidth: 1)
                    )
                    .offset(x: -30)
            }
            .frame(width: RatioSize.getResWidth(width: 230))
            // Gear Icon
            HStack{
                Spacer()
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .frame(width: RatioSize.getResWidth(width: 20), height: RatioSize.getResheight(height: 20))
                    .foregroundColor(.fontColor)
                    .padding()
            }
        }
        .frame(height: RatioSize.getResheight(height: 40))
    }
    
    // ContentViewBuilder
    @ViewBuilder func contentViewBuiler() -> some View {
        Text(content)
            .font(.custom(mainFont, size: 18))
            .lineSpacing(12)
    }
    
    // ButtonViewReloader
    @ViewBuilder func ButtonViewBuilder() -> some View {
        VStack{
            Text("누군가가 있는걸까?")
                .foregroundColor(.fontColor)
                .font(.custom(mainFontBold, size: 18))
                .frame(maxWidth: .infinity, maxHeight: RatioSize.getResheight(height: 60))
                .background(Color.bgColor)
                .cornerRadius(50)
                .shadow(color: Color("ButtonShadow"), radius: 3, x: 0, y: 0)
                .padding(.horizontal, 40)
                .padding(.vertical, RatioSize.getResheight(height: 5))

            Text("문으로 가까이 다가간다")
                .foregroundColor(.fontColor)
                .font(.custom(mainFontBold, size: 18))
                .frame(maxWidth: .infinity, maxHeight: RatioSize.getResheight(height: 60))
                .background(Color.bgColor)
                .cornerRadius(50)
                .shadow(color: Color("ButtonShadow"), radius: 3, x: 0, y: 0)
                .padding(.horizontal, 40)
                .padding(.vertical, RatioSize.getResheight(height: 5))
                .padding(.bottom, 10)
        }
        .padding(.bottom, 40)
    }
}
