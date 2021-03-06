//
//  EditScoreView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/5.
//

import SwiftUI

struct EditScoreView: View {
    @ObservedObject var dataStore:DataStore

    @State var input_all=""
    @State var input_today=""
    
    var body: some View {
        if dataStore.showEditScore{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(dataStore.isDark ? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)):Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .opacity(0.97)
                    .frame(width:screen.width*0.86,height: screen.height*0.66)
                
                VStack{
                    HStack{
                        Text("总得分：")
                            .font(.system(size: screen.width*0.068))
                        Spacer()
                    }
                    
                    Text("").frame(height:screen.height*0.03)

                    VStack(spacing:1){
                        TextField("", text: $input_all)
                            .font(.system(size: screen.width*0.06))
                            .frame(width:screen.width*0.67)

                        Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                            .frame(width:screen.width*0.67,height: 1)
                    }

                    Text("").frame(height:screen.height*0.05)

                    HStack{
                        Text("今天得分：")
                            .font(.system(size: screen.width*0.068))
                        Spacer()
                    }

                    Text("").frame(height:screen.height*0.03)

                    VStack(spacing:1){
                        TextField("", text: $input_today)
                            .font(.system(size: screen.width*0.06))
                            .frame(width:screen.width*0.67)

                        Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                            .frame(width:screen.width*0.67,height: 1)
                    }

                    Text("").frame(height:screen.height*0.12)
                    
                    HStack(spacing:screen.width*0.17){
                        Button(action: {
                            if let allScore=Int(input_all){
                                if let todayScore=Int(input_today){
                                    input_all=""
                                    input_today=""
                                    
                                    Save.sharedInstance.data.allScore=allScore
                                    Save.sharedInstance.data.todayScore=todayScore
                                    Save.sharedInstance.save()
                                    
                                    ContentView.dataStore.allScore="\(allScore)"
                                    ContentView.dataStore.todayScore="\(todayScore)"
                                    
                                    dataStore.showEditScore=false
                                    
                                    ContentView.toastStore.toast(text: "操作成功", kind: .success)
                                }else{
                                    ContentView.toastStore.toast(text: "请输入有效数字", kind: .error)
                                }
                            }else{
                                ContentView.toastStore.toast(text: "请输入有效数字", kind: .error)
                            }
                        }) {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                                    .opacity(0.7)
                                Text("完成")
                                    .font(.system(size: screen.width/16))
                                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            }
                            .frame(width:screen.width*0.17,height: screen.width*0.09)
                        }

                        Button(action: {
                            dataStore.showEditScore=false
                        }) {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                                    .opacity(0.7)
                                Text("取消")
                                    .font(.system(size: screen.width/16))
                                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            }
                            .frame(width:screen.width*0.17,height: screen.width*0.09)
                        }
                    }
                }
                .frame(width:screen.width*0.67)
                .onAppear{
                    input_all=dataStore.allScore
                    input_today=dataStore.todayScore
                }
            }
        }
        
        
    }
}

struct EditScoreView_Previews: PreviewProvider {
    static var previews: some View {
        EditScoreView(dataStore: DataStore())
    }
}
