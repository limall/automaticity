//
//  ScreenType.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/2.
//

import Foundation
import SwiftUI

enum ScreenType{
    case _se1
    case _6_6s_7_8_se2
    case _6p_6sp_7p_8p
    case _11p_x_xs_12mini
    case _11_xr_11pm_xsm
    case _12_12p
    case _12pm
    
    case default_bang
    case default_withoutBang
    
    static func getType(width:CGFloat,height:CGFloat)->ScreenType{
        if width==320&&height==568{
            return ._se1
        }else if width==375&&height==667{
            return ._6_6s_7_8_se2
        }else if width==414&&height==736{
            return ._6p_6sp_7p_8p
        }else if width==375&&height==812{
            return ._11p_x_xs_12mini
        }else if width==414&&height==896{
            return ._11_xr_11pm_xsm
        }else if width==390&&height==844{
            return ._12_12p
        }else if width==428&&height==926{
            return ._12pm
        }
        
        if height>750{
            return .default_bang
        }else{
            return .default_withoutBang
        }
    }
    
    static func ifWithBang(type:ScreenType)->Bool{
        switch type {
        case ._se1,._6_6s_7_8_se2,._6p_6sp_7p_8p,.default_withoutBang:
            return false
        default:
            return true
        }
    }
    
    static func ifWithBang(width:CGFloat,height:CGFloat)->Bool{
        let type=ScreenType.getType(width: width, height: height)
        return ifWithBang(type: type)
    }
}
