//
//  CreateOnceNuliView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/2.
//

import SwiftUI

struct CreateOnceNuliView: View {
    @State var title=""
    @State var rate=""
    
    var body: some View {
        VStack{
            HStack{
                Text("标题：")
                    .font(.system(size: screen.width*0.068))
                Spacer()
            }
            
            Text("").frame(height:screen.height*0.03)
            
            VStack(spacing:1){
                TextField("请输入标题", text: $title)
                    .font(.system(size: screen.width*0.06))
                    .frame(width:screen.width*0.74)
                
                Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                    .frame(width:screen.width*0.74,height: 1)
            }
            
            Text("").frame(height:screen.height*0.05)
            
            HStack{
                Text("每次得分：")
                    .font(.system(size: screen.width*0.068))
                Spacer()
            }
            
            Text("").frame(height:screen.height*0.03)
            
            VStack(spacing:1){
                TextField("请输入每次得分", text: $rate)
                    .font(.system(size: screen.width*0.06))
                    .frame(width:screen.width*0.74)
                
                Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                    .frame(width:screen.width*0.74,height: 1)
            }
            
            Text("").frame(height:screen.height*0.145)
            
            Button(action: {
                if let _ = Double(rate){
                    if title != ""{
                        if Save.sharedInstance.getNuliIndex(title: title) == -1 && Save.sharedInstance.getFangsongIndex(title: title) == -1{
                            Action.sharedInstance.createOnceNuli(title: title, rate: rate)
                            ContentView.toastStore.toast(text: "操作成功", kind: .success)
                        }else{
                            ContentView.toastStore.toast(text: "操作失败，标题名不可重复", kind: .error)
                        }
                    }else{
                        ContentView.toastStore.toast(text: "操作失败，请输入标题", kind: .error)
                    }
                }else{
                    ContentView.toastStore.toast(text: "操作失败，请输入有效数字", kind: .error)
                }
            }) {
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .opacity(0.7)
                    Text("创建")
                        .font(.system(size: screen.width/14))
                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                }
                .frame(width:screen.width*0.23,height: screen.width*0.11)
            }
        }
        .padding(.horizontal,screen.width*0.13)
    }
}

struct CreateOnceNuliView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOnceNuliView()
    }
}
