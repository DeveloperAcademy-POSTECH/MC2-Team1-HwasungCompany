//
//  SettingView.swift
//  MC2-Team1
//
//  Created by Seulki Lee on 2022/06/10.
//

import SwiftUI
import PartialSheet

struct SettingView: View {
    @State private var someBinding: Bool = true
    @State private var anotherBinding: Bool = true
    @State private var theOtherBinding: Bool = true
    @State private var isEditing = false
    @State var fontSize: CGFloat = 18.0
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Group {
                HStack {
                    Spacer()
                    Text("설정")
                        .font(.headline)
                    Spacer()
                }
                .padding(.vertical, 30)
                
                Toggle(isOn: $someBinding) {
                    Text("진동 효과")
                }
                
                Divider()
                
                Toggle(isOn: $anotherBinding) {
                    Text("텍스트 애니메이션 효과")
                }
                
                Divider()
                
                Toggle(isOn: $theOtherBinding) {
                    Text("사운드 효과")
                }
                
                Divider()
                
                Text("텍스트 크기")
                
                VStack {
                    Text("현재 텍스트 크기입니다.")
                    
                    HStack {
                        Text("가")
                        
                        Slider(
                            value: $fontSize,
                            in: 12...24, step: 1,
                            onEditingChanged: { editing in
                                isEditing = editing
                            }
                        )
                        .tint(.gray)
                        
                        Text("가")
                    }
                }
                .padding()
                
                Divider()
                
            }
            .padding(.horizontal, 10)
            
            Button(action: {
                showAlert = true
            }) {
                Text("게임 초기화")
            }
            .padding(.horizontal, 10)
            .alert(isPresented:$showAlert) {
                Alert(
                    title: Text("초기화 하시겠습니까?"),
                    message: Text("""
게임의 진행도가 초기화 됩니다.
이 행동은 되돌릴 수 없습니다.
"""),
                    primaryButton: .destructive(Text("확인")) {},
                    secondaryButton: .cancel(Text("취소"))
                )
            }
        }
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
