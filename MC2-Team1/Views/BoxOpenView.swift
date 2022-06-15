//
//  BoxOpenView.swift
//  MC2-Team1
//
//  Created by Shin yongjun on 2022/06/11.
//

import SwiftUI
import Lottie

struct BoxOpenView: View {
    @State private var dragCompleted = false
    @State private var showBox = true
    @State private var showInBox = false
    @State private var opac: Double = 0
    @State private var boxDec = "드래그해서 상자를 열어주세요"
    
    @State private var showBlack = false
    @State private var showWhite = true
    
    var body: some View {
        VStack {
            ZStack {
                if showBox {
                    LottieBox()
                        .gesture(
                            DragGesture(minimumDistance: RatioSize.getResWidth(width: 50))
                                .onEnded { _ in
                                    dragCompleted = true
                                    boxDec = "더블클릭해서 상자안을 봐주세요"
                                })
                    
                }
                
                if dragCompleted && showBox {
                    LottieBoxOpen()
                        .gesture(
                            TapGesture(count: 2)
                                .onEnded { _ in
                                    withAnimation(Animation.easeInOut.delay(1.5)) {
                                        showBox = false
                                        dragCompleted = false
                                        opac = 1
                                        boxDec = ""
                                        showInBox = true
                                    }
                                })
                    
                }
                
                if showInBox == true {
                    InBox()
                }
            }
            Text("\(boxDec)")
        }
    }
}

struct BoxOpenView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOpenView()
    }
}

/* https://stackoverflow.com/questions/66835559/swiftui-how-to-get-notified-when-dragging-and-releasing-on-an-view
 */

struct InBox: View {
    @Environment(\.presentationMode) var presentationMode
    
    typealias OffsetType = (offset: CGSize, lastOffset: CGSize)
    
    @State private var objects: [OffsetType] = [
        (offset: CGSize(width: -20, height: 0.0),
         lastOffset: CGSize(width: -20, height: 0.0)),
        
        (offset: CGSize(width: 40, height: 0.0),
         lastOffset: CGSize(width: 40, height: 0.0)),
        
        (offset: CGSize(width: 0.0, height: -200),
         lastOffset: CGSize(width: 0.0, height: -200)),
        
        (offset: CGSize(width: 0.0, height: 200),
         lastOffset: CGSize(width: 0.0, height: 200))
    ]
    
    @State private var Photo = false
    
    // MiniGame
    @AppStorage("isBoxOpenGame") var isBoxOpenGame = false
    
    var body: some View {
        
        ZStack {
            
            Image("InTheBox")
                .resizable()
                .foregroundColor(Color.brown)
                .frame(width: RatioSize.getResWidth(width: 400), height: RatioSize.getResWidth(width: 400))
            
            Image("BookFrame")
                .resizable()
                .frame(width: RatioSize.getResWidth(width: 100), height: RatioSize.getResWidth(width: 100), alignment: .center)
                .offset(objects[2].offset)
                .gesture(dragGesture(indexOfObject: 2, false))
            
            Image("DocFrame")
                .resizable()
                .frame(width: RatioSize.getResWidth(width: 100), height: RatioSize.getResWidth(width: 100), alignment: .center)
                .offset(objects[3].offset)
                .gesture(dragGesture(indexOfObject: 3, false))
            
            Image("Book")
                .resizable()
                .frame(width: RatioSize.getResWidth(width: 100), height: RatioSize.getResWidth(width: 100), alignment: .center)
                .offset(objects[0].offset)
                .gesture(dragGesture(indexOfObject: 0, true))
            
            Image("Doc")
                .resizable()
                .frame(width: RatioSize.getResWidth(width: 100), height: RatioSize.getResWidth(width: 100), alignment: .center)
                .offset(objects[1].offset)
                .gesture(dragGesture(indexOfObject: 1, true))
            
            
            if Photo == true {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: RatioSize.getResWidth(width: 1000), height: RatioSize.getResWidth(width: 1000))
                        .padding()
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("Photo")
                        .resizable()
                        .frame(width: RatioSize.getResWidth(width: 400), height: RatioSize.getResWidth(width: 400))
                        .padding()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                isBoxOpenGame = false
                            }
                        }
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
                
            }
        }
    }
    
    func dragGesture(indexOfObject: Int, _ canMove: Bool) -> some Gesture {
        
        DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
            .onChanged() { value in
                
                var nextWidth: CGFloat = 0
                var nextHeight: CGFloat = 0
                if canMove {
                    nextWidth = value.translation.width
                    nextHeight = value.translation.height
                }
                
                objects[indexOfObject].offset =
                CGSize(
                    width: objects[indexOfObject].lastOffset.width + nextWidth,
                    height: objects[indexOfObject].lastOffset.height + nextHeight
                )
                
            }
            .onEnded() { value in
                
                var nextWidth: CGFloat = 0
                var nextHeight: CGFloat = 0
                if canMove {
                    nextWidth = value.translation.width
                    nextHeight = value.translation.height
                }
                
                objects[indexOfObject].lastOffset =
                CGSize(
                    width: objects[indexOfObject].lastOffset.width + nextWidth,
                    height: objects[indexOfObject].lastOffset.height + nextHeight
                )
                
                objects[indexOfObject].offset = objects[indexOfObject].lastOffset
                
                distance()
                
            }
        
    }
    
    func distance(){
        let firstJob = pow(pow((objects[0].offset.width - objects[2].offset.width), 2.0) + pow((objects[0].offset.height - objects[2].offset.height), 2.0), 0.5) <= 100
        let secondJob = pow(pow((objects[1].offset.width - objects[3].offset.width), 2.0) + pow((objects[1].offset.height - objects[3].offset.height), 2.0), 0.5) <= 100
        if  firstJob == true && secondJob == true {
            Photo = true
        } else {
            Photo = false
        }
        
    }
}


struct LottieBoxOpen: UIViewRepresentable {
    var name = "openBox"
    var loopMode: LottieLoopMode = .playOnce
    
    func makeUIView(context: UIViewRepresentableContext<LottieBoxOpen>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}


struct LottieBox: UIViewRepresentable {
    var name = "openBox"
    var loopMode: LottieLoopMode = .playOnce
    
    func makeUIView(context: UIViewRepresentableContext<LottieBox>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

