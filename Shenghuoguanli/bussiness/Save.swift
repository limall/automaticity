//
//  Save.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/2.
//

import Foundation

let NULITYPE_CONTINUE=0
let NULITYPE_ONCE=1
let FANGSONGTYPE_CONTINUE=2
let FANGSONGTYPE_ONCE=3

class Save{
    static let sharedInstance=Save()
    
    var data:SaveData
    private init(){
        data=SaveData(allScore: 0, todayScore: 0, preDate: "", nuliDatas: [], fangsongDatas: [])
        if let localStr=UserDefaults.standard.string(forKey: "data"){
            let localData=localStr.data(using: .utf8)!
            let decoder=JSONDecoder()
            do{
                data=try decoder.decode(SaveData.self, from: localData)
            }catch{
                print("get data from local failed,json decode error:\(error.localizedDescription)")
            }
        }
    }
    
    func save(){
        let encoder=JSONEncoder()
        do{
            let jsonData = try encoder.encode(data)
            if let dataStr=String(data: jsonData, encoding: .utf8){
                UserDefaults.standard.set(dataStr,forKey: "data")
            }
        }catch{
            print("save data failed,encode json:\(error.localizedDescription)")
        }
    }
    
    func rankDatas(){
        rank(src: &data.nuliDatas)
        rank(src: &data.fangsongDatas)
    }
    
    func getNuliIndex(title:String)->Int{
        var index = -1
        for i in 0..<data.nuliDatas.count{
            if data.nuliDatas[i].title==title{
                index=i
            }
        }
        return index
    }
    
    func getNuliIndexWithExcept(title:String,except:String)->Int{
        var index = -1
        for i in 0..<data.nuliDatas.count{
            if title==except{
                continue
            }
            if data.nuliDatas[i].title==title{
                index=i
            }
        }
        return index
    }
    
    func getFangsongIndex(title:String)->Int{
        var index = -1
        for i in 0..<data.fangsongDatas.count{
            if data.fangsongDatas[i].title==title{
                index=i
            }
        }
        return index
    }
    
    func getFangsongIndexWithExcept(title:String,except:String)->Int{
        var index = -1
        for i in 0..<data.fangsongDatas.count{
            if title==except{
                continue
            }
            if data.fangsongDatas[i].title==title{
                index=i
            }
        }
        return index
    }
    
    struct NuliData:Codable,Rankable{
        let type:Int
        var title:String
        var rate:Double
        var startTime:Int
        var endTime:Int
        var todayTime:Int
        var todayScore:Int
        var lastTime:Int
    }
    
    struct FangsongData:Codable,Rankable{
        let type:Int
        var title:String
        var rate:Double
        var startTime:Int
        var endTime:Int
        var todayTime:Int
        var todayScore:Int
        var lastTime:Int
    }
    
    struct SaveData:Codable{
        var allScore:Int
        var todayScore:Int
        var preDate:String
        var nuliDatas:[NuliData]
        var fangsongDatas:[FangsongData]
    }
}

protocol Rankable {
    var lastTime:Int{get set}
}

func rank<T:Rankable>(src:inout [T]){
    if src.count<2{
        return
    }
    
    var temp:T
    var noChange=true
    
    for j in 0..<src.count-1{
        noChange=true
        for i in 0..<src.count-1-j{
            if src[i].lastTime<src[i+1].lastTime{
                temp=src[i]
                src[i]=src[i+1]
                src[i+1]=temp
                noChange=false
            }
        }
        if noChange{
            break
        }
    }
}
