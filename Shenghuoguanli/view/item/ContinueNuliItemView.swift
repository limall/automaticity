//
//  ContinueNuliItemView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/1.
//

import SwiftUI

struct ContinueNuliItemView: View {
    let title:String
    let rate:String
    
    let time:String
    let isDoing:Bool
    
    let todayTime:String
    let todayScore:String
    
    @ObservedObject var store:DataStore
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(width: screen.width*0.9,height: screen.width*0.37)
                .foregroundColor(store.isDark ? Color(#colorLiteral(red: 0.1237749234, green: 0.0543558076, blue: 0.03154901788, alpha: 1)) : Color(#colorLiteral(red: 0.9597939849, green: 0.912353754, blue: 0.8573412895, alpha: 1)))
            
            VStack(spacing:screen.width*0.077){
                HStack{
                    Text(title)
                        .font(.system(size: screen.width/20))
                    
                    Spacer()
                    
                    VStack(spacing:0){
                        Text(rate)
                            .font(.system(size: screen.width/28))
                        
                        Text("\(todayTime)|\(todayScore)")
                            .font(.system(size: screen.width/32))
                    }
                }
                
                HStack{
                    Button(action: {
                        Action.sharedInstance.startNuli(title: title)
                        ContentView.toastStore.toast(text: "操作成功", kind: .success)
                    }) {
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .opacity(0.7)
                            Text("开始")
                                .font(.system(size: screen.width/17))
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        }
                        .frame(width:screen.width*0.165,height: screen.width*0.085)
                    }
                    
                    Spacer()
                    
                    VStack{
                        if isDoing{
                            Text("doing")
                                .font(.system(size: screen.width*0.035))
                                .foregroundColor(.green)
                        }
                        Text(time)
                            .font(.system(size: screen.width*0.035))
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        Action.sharedInstance.endNuli(title: title)
                    }) {
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .opacity(0.7)
                            Text("结束")
                                .font(.system(size: screen.width/17))
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        }
                        .frame(width:screen.width*0.165,height: screen.width*0.085)
                    }
                }
            }
            .frame(width:screen.width*0.8)
        }
    }
}

struct ContinueNuliItemView_Previews: PreviewProvider {
    static var previews: some View {
        ContinueNuliItemView(title: "生活管家", rate: "4.0",time: "21日15:23",isDoing:true,todayTime: "100",todayScore: "150",store: DataStore())
    }
}
