//
//  Toast.swift
//  PostiveEnergy
//
//  Created by 左启凡 on 2020/7/25.
//  Copyright © 2020 zqf. All rights reserved.
//

import SwiftUI

struct ToastView: View {
    struct SizeKey:PreferenceKey{
        static let defaultValue: CGSize? = nil
        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            value=value ?? nextValue()
        }
    }
    
    @ObservedObject var store:ToastStore
    
    let fontSize=screen.width/20
    
    @State var textHeight:CGFloat=0
    @State var textWidth:CGFloat=0
    var body: some View {
        VStack {
            ZStack{
                if store.text.count>0{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.gray)
                        .frame(width:textWidth+23,height: textHeight+10)
                }
                
                ZStack{
                    Text(store.text)
                        .font(.system(size: fontSize))
//                        .foregroundColor(store.color)
                        .background(GeometryReader{proxy in
                            Color.clear.preference(key: SizeKey.self, value: proxy.size)
                        })
                        .onPreferenceChange(SizeKey.self){
                            if let size=$0{
                                self.textHeight=size.height
                                self.textWidth=size.width
                            }
                    }
                }
                .frame(width:screen.width/4*3)
            }
            .offset(y:screen.height/24*7)
        }
    }
}

struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(store: ToastStore())
    }
}
