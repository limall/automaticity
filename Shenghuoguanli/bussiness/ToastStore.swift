//
//  ToastStore.swift
//  ShaiShai
//
//  Created by 左启凡 on 2020/11/30.
//

import Foundation
import Combine
import SwiftUI

class ToastStore:ObservableObject{
    enum Kind {
        case success,warning,error
    }
    
    enum Time {
        case long,medium,short
    }
    
    @Published var text=""
    @Published var color=Color.orange
    
    func toast(text:String,kind:Kind,time:Time = .medium){
        DispatchQueue.main.async {
            switch kind {
            case .error:
                self.color = .red
            case .warning:
                self.color = .orange
            case .success:
                self.color = .green
            }
            
            var _time:Double
            switch time {
            case .short:
                _time=0.8
            case .medium:
                _time=1.3
            case .long:
                _time=2.5
            }
            
            self.text=text
            Timer.scheduledTimer(withTimeInterval: _time, repeats: false, block: {timer in
                self.text=""
            })
        }
    }
}
