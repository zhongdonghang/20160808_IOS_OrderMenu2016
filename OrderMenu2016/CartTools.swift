//
//  CartTools.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/8/9.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation

//购物车通用操作
class CartTools  {
    static let sysDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    //判断当前是否有购物车
    static func checkCartIsExist() ->Bool
    {
        var isTrue = false
        if(sysDefaults.objectForKey("Cart") != nil)
        {
            isTrue = true
        }
        return isTrue
    }
    
    //返回当前购物车
    static func getCurrentCart()->CartModel
    {
        let data:NSData =  sysDefaults.objectForKey("Cart") as! NSData
        let cart:CartModel = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! CartModel
        return cart
    }
    
    //移除当前购物车
    static func removeCart()
    {
        sysDefaults.removeObjectForKey("Cart")
        sysDefaults.synchronize()
    }
    
}