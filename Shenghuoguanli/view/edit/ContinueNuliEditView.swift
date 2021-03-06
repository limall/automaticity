//
//  ContinueNuliEditView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/5.
//

import SwiftUI

struct ContinueNuliEditView: View {
    let index:Int
    
    @State var title=""
    @State var rate=""
    
    @State var title_origin=""
    
    var body: some View {
        VStack{
            HStack{
                Text("标题：")
                    .font(.system(size: screen.width*0.068))
                Spacer()
            }
            
            Text("").frame(height:screen.height*0.03)
            
            VStack(spacing:1){
                TextField("", text: $title)
                    .font(.system(size: screen.width*0.06))
                    .frame(width:screen.width*0.74)
                
                Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                    .frame(width:screen.width*0.74,height: 1)
            }
            
            Text("").frame(height:screen.height*0.05)
            
            HStack{
                Text("比率：")
                    .font(.system(size: screen.width*0.068))
                Spacer()
            }
            
            Text("").frame(height:screen.height*0.03)
            
            VStack(spacing:1){
                TextField("", text: $rate)
                    .font(.system(size: screen.width*0.06))
                    .frame(width:screen.width*0.74)
                
                Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                    .frame(width:screen.width*0.74,height: 1)
            }
            
            Text("").frame(height:screen.height*0.145)
            
            HStack(spacing:screen.width*0.1){
                Button(action: {
                    if let _ = Double(rate){
                        if title != ""{
                            if Save.sharedInstance.getNuliIndexWithExcept(title: title, except: title_origin) == -1 && Save.sharedInstance.getFangsongIndexWithExcept(title: title, except: title_origin) == -1{
                                Action.sharedInstance.edit(oldTitile: title_origin, newTitle: title, rate: rate, type: NULITYPE_CONTINUE)
                                title_origin=title
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
                        Text("修改")
                            .font(.system(size: screen.width/16))
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                    .frame(width:screen.width*0.19,height: screen.width*0.09)
                }
                
                Button(action: {
                    deleteItemTitle=title_origin
                    ContentView.dataStore.showDeleteItem=true
                }) {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                            .opacity(0.7)
                        Text("删除")
                            .font(.system(size: screen.width/16))
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                    .frame(width:screen.width*0.19,height: screen.width*0.09)
                }
            }
            
            
        }
        .padding(.horizontal,screen.width*0.13)
        .onAppear{
            title_origin=ContentView.dataStore.allItems[index]
            title=title_origin
            rate=ContentView.dataStore.nuliDatas[ContentView.dataStore.getNuliIndex(title: title)].rate
        }
    }
}

struct ContinueNuliEditView_Previews: PreviewProvider {
    static var previews: some View {
        ContinueNuliEditView(index: 0)
    }
}
