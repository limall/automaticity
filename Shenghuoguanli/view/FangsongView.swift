//
//  FangsongView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/5.
//

import SwiftUI

struct FangsongView: View {
    @ObservedObject var dataStore:DataStore
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                Text("").frame(height:screen.height*0.004)
                HStack{
                    Text("总得分：")
                        .font(.system(size: screen.width*0.08))
                    
                    Text(dataStore.allScore)
                        .font(.system(size: screen.width*0.08))
                    
                    Spacer()
                }
                .frame(width: screen.width*0.9)
                
                Text("").frame(height:screen.height*0.016)
                
                FangsongFilterView(store: dataStore)
                
                Text("").frame(height:screen.height*0.016)
                
                ScrollView{
                    Text("")
                        .frame(width:screen.width)
                    ForEach(dataStore.fangsongDatas,id:\.self){fangsongData in
                        if fangsongData.type==FANGSONGTYPE_CONTINUE{
                            ContinueFangsongItemView(title: fangsongData.title, rate: fangsongData.rate, time: fangsongData.performTime,isDoing: fangsongData.isDoing, todayTime: fangsongData.todayTime, todayScore: fangsongData.todayScore,store: dataStore)
                        }else{
                            OnceFangsongItemView(title: fangsongData.title, rate: fangsongData.rate, lastTime: fangsongData.performTime,store: dataStore)
                        }
                    }
                    
                    Text("")
                        .frame(height:screen.height*0.025)
                }
                
                Spacer()
                
                Text("")
                    .frame(height:screen.height*0.06)
            }
            .edgesIgnoringSafeArea(.bottom)
            
            if dataStore.fangsongDatas.count==0{
                Text("还没有放松项，请在设置中创建")
            }
        }
    }
}

struct FangsongView_Previews: PreviewProvider {
    static var previews: some View {
        FangsongView(dataStore: DataStore())
    }
}
