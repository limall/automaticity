//
//  ContentView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/1.
//

import SwiftUI

let screen=UIScreen.main.bounds
let screenType=ScreenType.getType(width: screen.width, height: screen.height)
let ifWithBang=ScreenType.ifWithBang(type: screenType)

let currentMode=UITraitCollection.current.userInterfaceStyle

struct ContentView: View {
    
    @State var showNuli=true
    @State var showFangsong=false
    @State var showSetting=false
    
    @ObservedObject static var dataStore=DataStore()
    @ObservedObject static var toastStore=ToastStore()
    
    var body: some View {
        ZStack{
            if showSetting{
                SetMainView(dataStore: ContentView.dataStore)
            }
            
            if showNuli{
                NuliView(dataStore: ContentView.dataStore)
            }
            
            if showFangsong{
                FangsongView(dataStore: ContentView.dataStore)
            }
            
            MyNavigationView(showNuli: $showNuli, showFangsong: $showFangsong, showSetting: $showSetting,store: ContentView.dataStore)
            
            ZStack{
                BatchView(dataStore: ContentView.dataStore)
                EditScoreView(dataStore: ContentView.dataStore)
                DeleteItemView(dataStore: ContentView.dataStore)
            }
            
            ToastView(store: ContentView.toastStore)
        }
        .onAppear{
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
