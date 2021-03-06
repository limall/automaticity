//
//  util.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/3.
//

import Foundation

func getContinuePerformTimeStr(time:Int)->String{
    let date=Date(timeIntervalSince1970: TimeInterval(time))
    let dateFormatter=DateFormatter()
    dateFormatter.dateFormat="M月d日H时m分"
    let dateStr=dateFormatter.string(from: date)
    return dateStr
}

func getOncePerformTimeStr(time:Int)->String{
    let date=Date(timeIntervalSince1970: TimeInterval(time))
    let dateFormatter=DateFormatter()
    dateFormatter.dateFormat="M月d日"
    let dateStr=dateFormatter.string(from: date)
    return dateStr
}


