//
//  OnceFangsongItemView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/1.
//

import SwiftUI

struct OnceFangsongItemView: View {
    
    let title:String
    let rate:String
    
    let lastTime:String
    
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
                    
                    Text(rate)
                        .font(.system(size: screen.width/23))
                }
                
                HStack{
                    Button(action: {
                        Action.sharedInstance.onceFangsong(title: title, times: 1)
                        ContentView.toastStore.toast(text: "操作成功", kind: .success)
                    }) {
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .opacity(0.7)
                            Text("一次")
                                .font(.system(size: screen.width/17))
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        }
                        .frame(width:screen.width*0.165,height: screen.width*0.085)
                    }
                    
                    Spacer()
                    
                    Text(lastTime)
                    
                    Spacer()
                    
                    Button(action: {
                        batchTitle=title
                        batchType=FANGSONGTYPE_ONCE
                        ContentView.dataStore.showBatch=true
                    }) {
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .opacity(0.7)
                            Text("批量")
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

struct OnceFangsongItemView_Previews: PreviewProvider {
    static var previews: some View {
        OnceFangsongItemView(title: "吃高糖食品，不包括水果", rate: "60", lastTime: "3月29日",store: DataStore())
    }
}
