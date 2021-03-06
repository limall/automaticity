//
//  Action.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/2.
//

import Foundation

class Action{
    static let sharedInstance=Action()
    private init(){
    }
    
    func getAllNuliItemStores()->[DataStore.NuliData]{
        let data=Save.sharedInstance.data
        var stores=[DataStore.NuliData]()
        
        for nuliData in data.nuliDatas{
            var isDoing=false
            let performTime:String
            if nuliData.lastTime==0{
                performTime=""
            }else{
                if nuliData.type==NULITYPE_CONTINUE{
                    performTime=getContinuePerformTimeStr(time: nuliData.lastTime)
                    isDoing=nuliData.startTime>nuliData.endTime
                }else{
                    performTime=getOncePerformTimeStr(time: nuliData.lastTime)
                }
            }
            
            let nuliItemStore=DataStore.NuliData(type: nuliData.type, title: nuliData.title, rate: "\(nuliData.rate)", performTime: performTime, todayTime: "\(nuliData.todayTime)", todayScore: "\(nuliData.todayScore)",isDoing: isDoing)
            
            stores.append(nuliItemStore)
        }
        
        return stores
    }
    
    func getContinueNuliItemStores()->[DataStore.NuliData]{
        let allStores=getAllNuliItemStores()
        var stores=[DataStore.NuliData]()
        
        for store in allStores{
            if store.type==NULITYPE_CONTINUE{
                stores.append(store)
            }
        }
        
        return stores
    }
    
    func getOnceNuliItemStores()->[DataStore.NuliData]{
        let allStores=getAllNuliItemStores()
        var stores=[DataStore.NuliData]()
        
        for store in allStores{
            if store.type==NULITYPE_ONCE{
                stores.append(store)
            }
        }
        
        return stores
    }
    
    func getAllFangsongItemStores()->[DataStore.FangsongData]{
        let data=Save.sharedInstance.data
        var stores=[DataStore.FangsongData]()
        
        for fangsongData in data.fangsongDatas{
            var isDoing=false
            let performTime:String
            
            if fangsongData.lastTime==0{
                performTime=""
            }else{
                if fangsongData.type==FANGSONGTYPE_CONTINUE{
                    performTime=getContinuePerformTimeStr(time: fangsongData.lastTime)
                    isDoing=fangsongData.startTime>fangsongData.endTime
                }else{
                    performTime=getOncePerformTimeStr(time: fangsongData.lastTime)
                }
            }
            
            
            let fangsongItemStore=DataStore.FangsongData(type: fangsongData.type, title: fangsongData.title, rate: "\(fangsongData.rate)", performTime: performTime, todayTime: "\(fangsongData.todayTime)", todayScore: "\(fangsongData.todayScore)",isDoing: isDoing)
            
            stores.append(fangsongItemStore)
        }
        
        return stores
    }
    
    func getContinueFangsongItemStores()->[DataStore.FangsongData]{
        let allStores=getAllFangsongItemStores()
        var stores=[DataStore.FangsongData]()
        
        for store in allStores{
            if store.type==FANGSONGTYPE_CONTINUE{
                stores.append(store)
            }
        }
        
        return stores
    }
    
    func getOnceFangsongItemStores()->[DataStore.FangsongData]{
        let allStores=getAllFangsongItemStores()
        var stores=[DataStore.FangsongData]()
        
        for store in allStores{
            if store.type==FANGSONGTYPE_ONCE{
                stores.append(store)
            }
        }
        
        return stores
    }
    
    func initStore(){
        let data=Save.sharedInstance.data
        let store=ContentView.dataStore

        store.allScore="\(data.allScore)"
        store.todayScore="\(data.todayScore)"

        DispatchQueue.main.async {
            store.allItems=["前言","创建持续性努力","创建一次性努力","创建持续性放松","创建一次性放松","***分隔***"]
            for item in data.nuliDatas{
                store.allItems.append(item.title)
            }
            
            for item in data.fangsongDatas{
                store.allItems.append(item.title)
            }
            
            switch nuliFilterSelect{
            case .all:
                store.nuliDatas=self.getAllNuliItemStores()
            case .chixu:
                store.nuliDatas=self.getContinueNuliItemStores()
            case .once:
                store.nuliDatas=self.getOnceNuliItemStores()
            }
            switch fangsongFilterSelect{
            case .all:
                store.fangsongDatas=self.getAllFangsongItemStores()
            case .chixu:
                store.fangsongDatas=self.getContinueFangsongItemStores()
            case .once:
                store.fangsongDatas=self.getOnceFangsongItemStores()
            }
        }
    }
    
    func performOtherDay(){
        let preDate=Save.sharedInstance.data.preDate
        
        let now=Date()
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat="yyyy-MM-dd"
        let today=dateFormatter.string(from: now)
        
        if preDate != today{
            Save.sharedInstance.data.todayScore=0
            
            for i in 0..<Save.sharedInstance.data.nuliDatas.count{
                Save.sharedInstance.data.nuliDatas[i].todayTime=0
                Save.sharedInstance.data.nuliDatas[i].todayScore=0
            }
            
            for i in 0..<Save.sharedInstance.data.fangsongDatas.count{
                Save.sharedInstance.data.fangsongDatas[i].todayTime=0
                Save.sharedInstance.data.fangsongDatas[i].todayScore=0
            }
            
            Save.sharedInstance.data.preDate=today
            
            Save.sharedInstance.save()
            
            DispatchQueue.main.async {
                let store=ContentView.dataStore
                
                store.todayScore="0"
                
                for i in 0..<store.nuliDatas.count{
                    store.nuliDatas[i].todayTime="0"
                    store.nuliDatas[i].todayScore="0"
                }
                
                for i in 0..<store.fangsongDatas.count{
                    store.fangsongDatas[i].todayTime="0"
                    store.fangsongDatas[i].todayScore="0"
                }
            }
        }
    }
    
    func startFangsong(title:String){
        let nowTime=time(nil)
        
        let index1=Save.sharedInstance.getFangsongIndex(title: title)
        Save.sharedInstance.data.fangsongDatas[index1].startTime=nowTime
        Save.sharedInstance.data.fangsongDatas[index1].lastTime=nowTime
        Save.sharedInstance.save()
        
        let store=ContentView.dataStore
        let index2=store.getFangsongIndex(title: title)
        DispatchQueue.main.async {
            store.fangsongDatas[index2].performTime=getContinuePerformTimeStr(time: nowTime)
            store.fangsongDatas[index2].isDoing=true
        }
    }
    
    func startNuli(title:String){
        let nowTime=time(nil)
        
        let index1=Save.sharedInstance.getNuliIndex(title: title)
        Save.sharedInstance.data.nuliDatas[index1].startTime=nowTime
        Save.sharedInstance.data.nuliDatas[index1].lastTime=nowTime
        Save.sharedInstance.save()
        
        let store=ContentView.dataStore
        let index2=store.getNuliIndex(title: title)
        DispatchQueue.main.async {
            store.nuliDatas[index2].performTime=getContinuePerformTimeStr(time: nowTime)
            store.nuliDatas[index2].isDoing=true
        }
    }
    
    func endFangsong(title:String){
        let nowTime=time(nil)
        
        let index1=Save.sharedInstance.getFangsongIndex(title: title)
        let startTime=Save.sharedInstance.data.fangsongDatas[index1].startTime
        let oldEndTime=Save.sharedInstance.data.fangsongDatas[index1].endTime
        if startTime==0 || startTime <= oldEndTime{
            ContentView.toastStore.toast(text: "还没开始", kind: .error)
            return
        }
        let rate=Save.sharedInstance.data.fangsongDatas[index1].rate
        let fangsongTime=(nowTime-startTime)/60
        let score=Int(Double(nowTime-startTime)/60*rate)
        
        Save.sharedInstance.data.allScore -= score
        Save.sharedInstance.data.fangsongDatas[index1].endTime=nowTime
        Save.sharedInstance.data.fangsongDatas[index1].lastTime=nowTime
        Save.sharedInstance.data.fangsongDatas[index1].todayTime += fangsongTime
        Save.sharedInstance.data.fangsongDatas[index1].todayScore += score
        Save.sharedInstance.save()
        
        let store=ContentView.dataStore
        let index2=store.getFangsongIndex(title: title)
        DispatchQueue.main.async {
            store.allScore="\(Save.sharedInstance.data.allScore)"
            store.fangsongDatas[index2].performTime=getContinuePerformTimeStr(time: nowTime)
            store.fangsongDatas[index2].todayTime="\(Save.sharedInstance.data.fangsongDatas[index1].todayTime)"
            store.fangsongDatas[index2].todayScore="\(Save.sharedInstance.data.fangsongDatas[index1].todayScore)"
            store.fangsongDatas[index2].isDoing=false
        }
        
        ContentView.toastStore.toast(text: "操作成功", kind: .success)
    }
    
    func endNuli(title:String){
        let nowTime=time(nil)
        
        let index1=Save.sharedInstance.getNuliIndex(title: title)
        let startTime=Save.sharedInstance.data.nuliDatas[index1].startTime
        let oldEndTime=Save.sharedInstance.data.nuliDatas[index1].endTime
        if startTime==0 || startTime <= oldEndTime{
            ContentView.toastStore.toast(text: "还没开始", kind: .error)
            return
        }
        let rate=Save.sharedInstance.data.nuliDatas[index1].rate
        let nuliTime=(nowTime-startTime)/60
        let score=Int(Double(nowTime-startTime)/60*rate)
        
        Save.sharedInstance.data.todayScore += score
        Save.sharedInstance.data.allScore += score
        Save.sharedInstance.data.nuliDatas[index1].endTime=nowTime
        Save.sharedInstance.data.nuliDatas[index1].lastTime=nowTime
        Save.sharedInstance.data.nuliDatas[index1].todayTime += nuliTime
        Save.sharedInstance.data.nuliDatas[index1].todayScore += score
        Save.sharedInstance.save()
        
        let store=ContentView.dataStore
        let index2=store.getNuliIndex(title: title)
        DispatchQueue.main.async {
            store.allScore="\(Save.sharedInstance.data.allScore)"
            store.todayScore="\(Save.sharedInstance.data.todayScore)"
            store.nuliDatas[index2].performTime=getContinuePerformTimeStr(time: nowTime)
            store.nuliDatas[index2].todayTime="\(Save.sharedInstance.data.nuliDatas[index1].todayTime)"
            store.nuliDatas[index2].todayScore="\(Save.sharedInstance.data.nuliDatas[index1].todayScore)"
            store.nuliDatas[index2].isDoing=false
        }
        
        ContentView.toastStore.toast(text: "操作成功", kind: .success)
    }
    
    func onceFangsong(title:String,times:Int){
        let nowTime=time(nil)
        
        let index1=Save.sharedInstance.getFangsongIndex(title: title)
        let onceScore=Int(Save.sharedInstance.data.fangsongDatas[index1].rate*Double(times))
        
        Save.sharedInstance.data.fangsongDatas[index1].lastTime=nowTime
        Save.sharedInstance.data.allScore -= onceScore
        Save.sharedInstance.save()
        
        let store=ContentView.dataStore
        let index2=store.getFangsongIndex(title: title)
        DispatchQueue.main.async {
            store.allScore="\(Save.sharedInstance.data.allScore)"
            store.fangsongDatas[index2].performTime=getOncePerformTimeStr(time: nowTime)
        }
    }
    
    func onceNuli(title:String,times:Int){
        let nowTime=time(nil)
        
        let index1=Save.sharedInstance.getNuliIndex(title: title)
        let onceScore=Int(Save.sharedInstance.data.nuliDatas[index1].rate*Double(times))
        
        Save.sharedInstance.data.nuliDatas[index1].lastTime=nowTime
        Save.sharedInstance.data.allScore += onceScore
        Save.sharedInstance.data.todayScore += onceScore
        Save.sharedInstance.save()
        
        let store=ContentView.dataStore
        let index2=store.getNuliIndex(title: title)
        DispatchQueue.main.async {
            store.allScore="\(Save.sharedInstance.data.allScore)"
            store.todayScore="\(Save.sharedInstance.data.todayScore)"
            store.nuliDatas[index2].performTime=getOncePerformTimeStr(time: nowTime)
        }
    }
    
    func createContinueNuli(title:String,rate:String){        
        if let rateDouble=Double(rate){
            let nuliSave=Save.NuliData(type: NULITYPE_CONTINUE, title: title, rate: rateDouble, startTime: 0, endTime: 0, todayTime: 0, todayScore: 0, lastTime: 0)
            Save.sharedInstance.data.nuliDatas.append(nuliSave)
            Save.sharedInstance.save()
            
            let nuliData=DataStore.NuliData(type: NULITYPE_CONTINUE, title: title, rate: rate, performTime: "", todayTime: "", todayScore: "",isDoing: false)
            DispatchQueue.main.async {
                if nuliFilterSelect == .all || nuliFilterSelect == .chixu{
                    ContentView.dataStore.nuliDatas.append(nuliData)
                }
                ContentView.dataStore.allItems.append(title)
            }
        }
    }
    
    func createOnceNuli(title:String,rate:String){
        if let rateDouble=Double(rate){
            let nuliSave=Save.NuliData(type: NULITYPE_ONCE, title: title, rate: rateDouble, startTime: 0, endTime: 0, todayTime: 0, todayScore: 0, lastTime: 0)
            Save.sharedInstance.data.nuliDatas.append(nuliSave)
            Save.sharedInstance.save()
            
            let nuliData=DataStore.NuliData(type: NULITYPE_ONCE, title: title, rate: rate, performTime: "", todayTime: "", todayScore: "", isDoing: false)
            DispatchQueue.main.async {
                if nuliFilterSelect == .all || nuliFilterSelect == .once{
                    ContentView.dataStore.nuliDatas.append(nuliData)
                }
                ContentView.dataStore.allItems.append(title)
            }
        }
    }
    
    func createContinueFangsong(title:String,rate:String){
        if let rateDouble=Double(rate){
            let fangsongSave=Save.FangsongData(type: FANGSONGTYPE_CONTINUE, title: title, rate: rateDouble, startTime: 0, endTime: 0, todayTime: 0, todayScore: 0, lastTime: 0)
            Save.sharedInstance.data.fangsongDatas.append(fangsongSave)
            Save.sharedInstance.save()
            
            let fangsongData=DataStore.FangsongData(type: FANGSONGTYPE_CONTINUE, title: title, rate: rate, performTime: "", todayTime: "", todayScore: "", isDoing: false)
            DispatchQueue.main.async {
                if fangsongFilterSelect == .all || fangsongFilterSelect == .chixu{
                    ContentView.dataStore.fangsongDatas.append(fangsongData)
                }
                ContentView.dataStore.allItems.append(title)
            }
        }
    }
    
    func createOnceFangsong(title:String,rate:String){
        if let rateDouble=Double(rate){
            let fangsongSave=Save.FangsongData(type: FANGSONGTYPE_ONCE, title: title, rate: rateDouble, startTime: 0, endTime: 0, todayTime: 0, todayScore: 0, lastTime: 0)
            Save.sharedInstance.data.fangsongDatas.append(fangsongSave)
            Save.sharedInstance.save()
            
            let fangsongData=DataStore.FangsongData(type: FANGSONGTYPE_ONCE, title: title, rate: rate, performTime: "", todayTime: "", todayScore: "", isDoing: false)
            DispatchQueue.main.async {
                if fangsongFilterSelect == .all || fangsongFilterSelect == .once{
                    ContentView.dataStore.fangsongDatas.append(fangsongData)
                }
                ContentView.dataStore.allItems.append(title)
            }
        }
    }
    
    func edit(oldTitile:String,newTitle:String,rate:String,type:Int){
        if let rateDouble=Double(rate){
            if type==NULITYPE_CONTINUE || type==NULITYPE_ONCE{
                let index1=Save.sharedInstance.getNuliIndex(title: oldTitile)
                Save.sharedInstance.data.nuliDatas[index1].title=newTitle
                Save.sharedInstance.data.nuliDatas[index1].rate=rateDouble
                Save.sharedInstance.save()
                
                let index2=ContentView.dataStore.getNuliIndex(title: oldTitile)
                let index3=ContentView.dataStore.allItems.firstIndex(of: oldTitile)
                DispatchQueue.main.async {
                    if index2>=0{
                        ContentView.dataStore.nuliDatas[index2].title=newTitle
                        ContentView.dataStore.nuliDatas[index2].rate=rate
                        ContentView.dataStore.allItems[index3!]=newTitle
                    }
                }
            }else{
                let index1=Save.sharedInstance.getFangsongIndex(title: oldTitile)
                Save.sharedInstance.data.fangsongDatas[index1].title=newTitle
                Save.sharedInstance.data.fangsongDatas[index1].rate=rateDouble
                Save.sharedInstance.save()
                
                let index2=ContentView.dataStore.getFangsongIndex(title: oldTitile)
                let index3=ContentView.dataStore.allItems.firstIndex(of: oldTitile)
                DispatchQueue.main.async {
                    if index2>=0{
                        ContentView.dataStore.fangsongDatas[index2].title=newTitle
                        ContentView.dataStore.fangsongDatas[index2].rate=rate
                        ContentView.dataStore.allItems[index3!]=newTitle
                    }
                }
            }
        }
    }
    
    func delete(title:String){
        var index=Save.sharedInstance.getNuliIndex(title: title)
        if index>=0{
            Save.sharedInstance.data.nuliDatas.remove(at: index)
            Save.sharedInstance.save()
            
            DispatchQueue.main.async {
                let index1=ContentView.dataStore.getNuliIndex(title: title)
                let index2=ContentView.dataStore.allItems.firstIndex(of: title)!
                ContentView.dataStore.allItems.remove(at: index2)
                if index1>=0{
                    ContentView.dataStore.nuliDatas.remove(at: index1)
                }
            }
        }else{
            index=Save.sharedInstance.getFangsongIndex(title: title)
            Save.sharedInstance.data.fangsongDatas.remove(at: index)
            Save.sharedInstance.save()
            
            DispatchQueue.main.async {
                let index3=ContentView.dataStore.getFangsongIndex(title: title)
                let index4=ContentView.dataStore.allItems.firstIndex(of: title)!
                ContentView.dataStore.allItems.remove(at: index4)
                if index3>=0{
                    ContentView.dataStore.fangsongDatas.remove(at: index3)
                }
            }
        }
    }
}
