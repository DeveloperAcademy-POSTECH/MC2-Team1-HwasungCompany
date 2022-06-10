//
//  DotView.swift
//  MC2-Team1
//
//  Created by leejunmo on 2022/06/09.
//

import SwiftUI

struct DotView: View {
    
    @State private var isAnimating: Bool = true
    
    var circleIndex: Int = 1
    var chapterIndex: Int = 1
    
    var body: some View {
        ZStack {
            if circleIndex == chapterIndex {
                Circle()
                    .frame(width: 29, height: 29)
                    .foregroundColor(Color.fontColor)
                    .scaleEffect(isAnimating ? 1:1.12)
                Circle()
                    .frame(width: 23, height: 23)
                    .foregroundColor(Color.bgColor)
                    .scaleEffect(isAnimating ? 1:1.18)
            }
            Circle()
                .frame(width: 17, height: 17)
                .foregroundColor(circleIndex >= chapterIndex ? .fontColor:.pastColor)
        }.onAppear {
            guard circleIndex == chapterIndex else { return }
            
            withAnimation(.spring().repeatForever()) {
                isAnimating.toggle()
            }
        }
    }
}

struct DotView_Previews: PreviewProvider {
    static var previews: some View {
        DotView(circleIndex: 1, chapterIndex: 1)
    }
}
