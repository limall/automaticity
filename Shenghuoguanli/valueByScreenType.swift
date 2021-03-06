//
//  ValueByScreenType.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/2.
//

import Foundation
import SwiftUI

var designValues=[String:CGFloat]()

func initDesignValues(type:ScreenType){
    let preset_designValues_SetContentViewOffset:[ScreenType:CGFloat]=[
        ._se1:-screen.height*0.1,
        ._6_6s_7_8_se2:-screen.height*0.1,
        ._6p_6sp_7p_8p:-screen.height*0.08,
        ._11p_x_xs_12mini:-screen.height*0.064,
        ._11_xr_11pm_xsm:-screen.height*0.064,
        ._12_12p:-screen.height*0.064,
        ._12pm:-screen.height*0.064,
        .default_bang:-screen.height*0.064,
        .default_withoutBang:-screen.height*0.1
    ]
    
    let preset_designValues_EditMainViewOffset:[ScreenType:CGFloat]=[
        ._se1:screen.height*0.05,
        ._6_6s_7_8_se2:screen.height*0.12,
        ._6p_6sp_7p_8p:screen.height*0.04,
        ._11p_x_xs_12mini:screen.height*0.032,
        ._11_xr_11pm_xsm:screen.height*0.032,
        ._12_12p:screen.height*0.032,
        ._12pm:screen.height*0.032,
        .default_bang:screen.height*0.032,
        .default_withoutBang:screen.height*0.05
    ]
    
    designValues["SetContentView_offset"]=preset_designValues_SetContentViewOffset[type]!
    designValues["EditMainViewA_offset"]=preset_designValues_EditMainViewOffset[type]!
}
