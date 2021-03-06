//
//  DataStore.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/2.
//

import Foundation
import Combine

class DataStore:ObservableObject{
    struct NuliData:Hashable{
        let type:Int
        var title:String
        var rate:String
        var performTime:String
        var todayTime:String
        var todayScore:String
        var isDoing:Bool
    }
    
    struct FangsongData:Hashable{
        let type:Int
        var title:String
        var rate:String
        var performTime:String
        var todayTime:String
        var todayScore:String
        var isDoing:Bool
    }
    
    @Published var allScore="0"
    @Published var todayScore="0"
    @Published var nuliDatas=[NuliData]()
    @Published var fangsongDatas=[FangsongData]()
    @Published var allItems=[String]()
    
    @Published var isDark=currentMode == .dark
    
    //用来控制
    @Published var showBatch=false
    @Published var showEditScore=false
    @Published var showDeleteItem=false
    @Published var showSetView=true
    
    func getNuliIndex(title:String)->Int{
        var index = -1
        for i in 0..<nuliDatas.count{
            if nuliDatas[i].title==title{
                index=i
            }
        }
        return index
    }
    
    func getFangsongIndex(title:String)->Int{
        var index = -1
        for i in 0..<fangsongDatas.count{
            if fangsongDatas[i].title==title{
                index=i
            }
        }
        return index
    }
}
