//
//  OrderViewModel.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/8/19.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation

//订单主体模型
class OrderViewModel:NSObject {
    
    var orderNo = ""
    var MemberName = ""
    var CreateTime = ""
    var Dec = ""
    var Seat = ""
    var PeopleNum = ""
    
    var Items:[OrderItemViewModel] = []
    
    func getDesc() -> String {
        var result = ""
        for item in Items {
            result = result+item.ProductCname
            result = result+"|"
        }
        return result
    }
    
    func getTotal() -> String {
        var total:Double = 0.0
        for it in Items {
            let price:Double = (it.Price1 as NSString).doubleValue
            total = total + price
        }
        return "\(total)"
    }
}