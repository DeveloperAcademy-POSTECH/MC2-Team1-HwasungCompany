//
//  OnBoardingView.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/06/14.
//

import SwiftUI

struct OnBoardingView: View {
    
    // Param
    @Binding var isFirstLaunching: Bool
    
    //Define
    @Environment(\.colorScheme) var colorScheme
    let lightGray = UIColor(Color(red: 200/255, green: 200/255, blue: 200/255))
    let darkGray = UIColor(Color(red: 120/255, green: 120/255, blue: 120/255))
    
    var body: some View {
        TabView{
            OnBoardingPageView(pageNumber: 1)
            OnBoardingPageView(pageNumber: 2)
            OnBoardingPageView(pageNumber: 3)
            OnBoardingPageView(pageNumber: 4)
            OnBoardingLastPageView(isFirstLaunching: $isFirstLaunching)
        }
        .tabViewStyle(PageTabViewStyle())
        .background(Color.bgColor)
        .onAppear{
            UIPageControl.appearance().currentPageIndicatorTintColor = colorScheme == .dark ?  .white : darkGray
            UIPageControl.appearance().pageIndicatorTintColor = colorScheme == .dark ? darkGray : .white
        }
    }
}
