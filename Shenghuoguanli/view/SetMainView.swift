//
//  SetMainView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/1.
//

import SwiftUI

struct SetMainView: View {
    @ObservedObject var dataStore:DataStore
    var body: some View {
        if dataStore.showSetView{
            NavigationView{
                List{
                    ForEach(dataStore.allItems.indices,id:\.self){index in
                        if index==5{
                            if dataStore.allItems.count>6{
                                Text(dataStore.allItems[5])
                                    .foregroundColor(.gray)
                            }
                        }else{
                            NavigationLink(destination:ZStack{
                                SetContentView(itemIndex:index)
                            }){
                                Text(dataStore.allItems[index])
                            }
                        }
                    }
                    
                    Text("")
                    Text("")
                }
                .navigationBarTitle("设置")
            }
        }
    }
}

struct SetMainView_Previews: PreviewProvider {
    static var previews: some View {
        SetMainView(dataStore: DataStore())
    }
}
