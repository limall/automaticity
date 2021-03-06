//
//  FangsongFilterView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/5.
//

import SwiftUI

enum FangsongFilterSelectType{
    case all,chixu,once
}

var fangsongFilterSelect = FangsongFilterSelectType.all

struct FangsongFilterView: View {
    @State var selectX = NuliFilterView.x4all
    
    @ObservedObject var store:DataStore
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 3))
                .frame(width:screen.width*0.2,height: screen.width*0.07)
                .offset(x:selectX)
                .animation(.easeInOut)
            
            Button(action: {
                selectX=NuliFilterView.x4all
                fangsongFilterSelect = .all
                DispatchQueue.main.async {
                    ContentView.dataStore.fangsongDatas=Action.sharedInstance.getAllFangsongItemStores()
                }
            }) {
                ZStack{
                    Image(uiImage: UIImage(#imageLiteral(resourceName: "cover_cover")))
                        .resizable()
                        .frame(width:screen.width*0.13,height:screen.width*0.07)
                    Text("全部")
                        .font(.system(size: screen.width*0.05))
                        .foregroundColor(store.isDark ? .white:.black)
                }
                .frame(width:screen.width*0.13,height: screen.width*0.07)
            }
            .offset(x:NuliFilterView.x4all)
            
            Button(action: {
                selectX=NuliFilterView.x4continue
                fangsongFilterSelect = .chixu
                DispatchQueue.main.async {
                    ContentView.dataStore.fangsongDatas=Action.sharedInstance.getContinueFangsongItemStores()
                }
            }) {
                ZStack{
                    Image(uiImage: UIImage(#imageLiteral(resourceName: "cover_cover")))
                        .resizable()
                        .frame(width:screen.width*0.2,height:screen.width*0.07)
                    Text("持续性")
                        .font(.system(size: screen.width*0.05))
                        .foregroundColor(store.isDark ? .white:.black)
                }
                .frame(width:screen.width*0.2,height: screen.width*0.07)
            }
            .offset(x:NuliFilterView.x4continue)
            
            Button(action: {
                selectX=NuliFilterView.x4once
                fangsongFilterSelect = .once
                DispatchQueue.main.async {
                    ContentView.dataStore.fangsongDatas=Action.sharedInstance.getOnceFangsongItemStores()
                }
            }) {
                ZStack{
                    Image(uiImage: UIImage(#imageLiteral(resourceName: "cover_cover")))
                        .resizable()
                        .frame(width:screen.width*0.2,height:screen.width*0.07)
                    Text("一次性")
                        .font(.system(size: screen.width*0.05))
                        .foregroundColor(store.isDark ? .white:.black)
                }
                .frame(width:screen.width*0.2,height: screen.width*0.07)
            }
            .offset(x:NuliFilterView.x4once)
            
        }
        .onAppear{
            switch fangsongFilterSelect{
            case .all:
                selectX = NuliFilterView.x4all
            case .chixu:
                selectX=NuliFilterView.x4continue
            case .once:
                selectX=NuliFilterView.x4once
            }
        }
    }
}

struct FangsongFilterView_Previews: PreviewProvider {
    static var previews: some View {
        FangsongFilterView(store: DataStore())
    }
}
