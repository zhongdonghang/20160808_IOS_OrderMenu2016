//
//  CommonTools.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/9/11.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation

class CommonTools {
    
    //价格字符串截取小数点后一位（到角）
    static func getPriceString(oldPriceString:String)->String
    {
        var price:Double = 0.0
        price = (oldPriceString as NSString).doubleValue;
        
        return "\(price)"
    }
    
}