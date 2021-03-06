//
//  NuliView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/2.
//

import SwiftUI

struct NuliView: View {
    @ObservedObject var dataStore:DataStore
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                NuliTitle(allScore: dataStore.allScore, todayScore: dataStore.todayScore)
                
                Text("").frame(height:screen.height*0.016)
                
                NuliFilterView(store: dataStore)
                
                Text("").frame(height:screen.height*0.016)
                
                ScrollView{
                    Text("")
                        .frame(width:screen.width)
                    ForEach(dataStore.nuliDatas,id:\.self){nuliData in
                        if nuliData.type==NULITYPE_CONTINUE{
                            ContinueNuliItemView(title: nuliData.title, rate: nuliData.rate, time: nuliData.performTime,isDoing: nuliData.isDoing, todayTime: nuliData.todayTime, todayScore: nuliData.todayScore,store: dataStore)
                        }else{
                            OnceNuliItemView(title: nuliData.title, rate: nuliData.rate, lastTime: nuliData.performTime,store: dataStore)
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
            
            if dataStore.nuliDatas.count==0{
                Text("还没有努力项，请在设置中创建")
            }
        }
        
    }
}

struct NuliView_Previews: PreviewProvider {
    static var previews: some View {
        NuliView(dataStore: DataStore())
    }
}
