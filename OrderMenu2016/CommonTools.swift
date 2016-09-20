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
    
    //购物车商品数量，取出字符串小数点后
    static func quxiaoshudianhoudeling(testNumber:String) -> String{
        
        var outNumber = testNumber
        var i = 1
        
        if testNumber.containsString("."){
            while i < testNumber.characters.count{
                if outNumber.hasSuffix("0"){
                    outNumber.removeAtIndex(outNumber.endIndex.predecessor())
                    i = i + 1
                }else{
                    break
                }
            }
            if outNumber.hasSuffix("."){
                outNumber.removeAtIndex(outNumber.endIndex.predecessor())
            }
            return outNumber
        }
        else{
            return testNumber
        }
    }
    
}