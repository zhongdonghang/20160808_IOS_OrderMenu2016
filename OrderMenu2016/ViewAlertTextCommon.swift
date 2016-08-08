//
//  ViewAlertTextCommon.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/26.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation

class ViewAlertTextCommon {
    
    static func ShowSimpleText(msg:String,view:UIView) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.label.text = msg
        hud.hideAnimated(true, afterDelay: 1)
    }
    
    static func ShowSimpleTextWith3(msg:String,view:UIView) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.label.text = msg
        hud.hideAnimated(true, afterDelay: 3)
    }
    
}