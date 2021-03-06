//
//  DeleteItemView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/5.
//

import SwiftUI

var deleteItemTitle=""

struct DeleteItemView: View {
    @ObservedObject var dataStore:DataStore
    var body: some View {
        if dataStore.showDeleteItem{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(dataStore.isDark ? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)):Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .opacity(0.97)
                
                VStack(spacing:screen.width*0.09){
                    Text("确定要删除\(deleteItemTitle)吗？")
                        .frame(width:screen.width*0.5,height: screen.width*0.125)
                    
                    HStack(spacing:screen.width*0.1){
                        Button(action: {
                            Action.sharedInstance.delete(title: deleteItemTitle)
                            ContentView.toastStore.toast(text: "操作成功", kind: .success)
                            
                            ContentView.dataStore.showSetView=false
                            Timer.scheduledTimer(withTimeInterval: 0.09, repeats: false, block: {timer in
                                ContentView.dataStore.showSetView=true
                                dataStore.showDeleteItem=false
                            })
                        }) {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .opacity(0.7)
                                Text("删除")
                                    .font(.system(size: screen.width/17))
                                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            }
                            .frame(width:screen.width*0.165,height: screen.width*0.085)
                        }
                        
                        Button(action: {
                            dataStore.showDeleteItem=false
                        }) {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .opacity(0.7)
                                Text("取消")
                                    .font(.system(size: screen.width/17))
                                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            }
                            .frame(width:screen.width*0.165,height: screen.width*0.085)
                        }
                    }
                }
            }
            .frame(width:screen.width*0.75,height: screen.width*0.5)
        }
    }
}

struct DeleteItemView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteItemView(dataStore: DataStore())
    }
}
