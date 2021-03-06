//
//  SetContentView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/2.
//

import SwiftUI

struct SetContentView: View {
    let itemIndex:Int
    
    @State var editType = -1
    
    var body: some View {
        ZStack{
            if itemIndex==0{
                IntroductionView()
            }else if itemIndex==1{
                CreateContinueNuliView()
            }else if itemIndex==2{
                CreateOnceNuliView()
            }else if itemIndex==3{
                CreateContinueFangsongView()
            }else if itemIndex==4{
                CreateOnceFangsongView()
            }else{
                if editType == -1{
                    Text("")
                }else if editType == NULITYPE_CONTINUE{
                    ContinueNuliEditView(index: itemIndex)
                }else if editType == NULITYPE_ONCE{
                    OnceNuliEditView(index:itemIndex)
                }else if editType == FANGSONGTYPE_CONTINUE{
                    ContinueFangsongEditView(index:itemIndex)
                }else if editType == FANGSONGTYPE_ONCE{
                    OnceFangsongEditView(index:itemIndex)
                }
            }
        }
        .offset(y:designValues["SetContentView_offset"]!)
        .onAppear{
            if itemIndex>4{
                let title=ContentView.dataStore.allItems[itemIndex]
                var i=ContentView.dataStore.getNuliIndex(title: title)
                if i == -1{
                    i=ContentView.dataStore.getFangsongIndex(title: title)
                    editType=ContentView.dataStore.fangsongDatas[i].type
                }else{
                    editType=ContentView.dataStore.nuliDatas[i].type
                }
            }
        }
    }
}

struct SetContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetContentView(itemIndex:0)
    }
}
