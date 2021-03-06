//
//  BatchView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/3.
//

import SwiftUI

var batchType = -1
var batchTitle = ""

struct BatchView: View {
    @ObservedObject var dataStore:DataStore
    
    @State var input=""
    
    var body: some View {
        if dataStore.showBatch{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(dataStore.isDark ? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)):Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .opacity(0.97)
                
                VStack(spacing:screen.width*0.106){
                    VStack(spacing:1){
                        TextField("请输入次数", text: $input)
                            .font(.system(size: screen.width*0.06))
                            .frame(width:screen.width*0.55)
                        
                        Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                            .frame(width:screen.width*0.55,height: 1)
                    }
                    HStack(spacing:screen.width*0.12){
                        Button(action: {
                            if let times=Int(input){
                                if batchType==NULITYPE_ONCE{
                                    Action.sharedInstance.onceNuli(title: batchTitle, times: times)
                                }else{
                                    Action.sharedInstance.onceFangsong(title: batchTitle, times: times)
                                }
                                ContentView.toastStore.toast(text: "操作成功", kind: .success)
                                dataStore.showBatch=false
                                input=""
                            }else{
                                ContentView.toastStore.toast(text: "请输入次数，必须为数字", kind: .error)
                            }
                        }) {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .opacity(0.7)
                                Text("确定")
                                    .font(.system(size: screen.width/17))
                                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            }
                            .frame(width:screen.width*0.165,height: screen.width*0.085)
                        }
                        
                        Button(action: {
                            dataStore.showBatch=false
                            input=""
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
            .frame(width:screen.width*0.75,height: screen.width*0.55)
        }
    }
}

struct BatchView_Previews: PreviewProvider {
    static var previews: some View {
        BatchView(dataStore: DataStore())
    }
}
