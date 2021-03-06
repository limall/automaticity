//
//  NuliFilterView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/3.
//

import SwiftUI

enum NuliFilterSelectType{
    case all,chixu,once
}

var nuliFilterSelect = NuliFilterSelectType.all

struct NuliFilterView: View {
    static let x4all = -screen.width*0.35
    static let x4continue = -screen.width*0.15
    static let x4once = screen.width*0.08
    
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
                nuliFilterSelect = .all
                DispatchQueue.main.async {
                    ContentView.dataStore.nuliDatas=Action.sharedInstance.getAllNuliItemStores()
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
                nuliFilterSelect = .chixu
                DispatchQueue.main.async {
                    ContentView.dataStore.nuliDatas=Action.sharedInstance.getContinueNuliItemStores()
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
                nuliFilterSelect = .once
                DispatchQueue.main.async {
                    ContentView.dataStore.nuliDatas=Action.sharedInstance.getOnceNuliItemStores()
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
            switch nuliFilterSelect{
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

struct NuliFilterView_Previews: PreviewProvider {
    static var previews: some View {
        NuliFilterView(store: DataStore())
    }
}
