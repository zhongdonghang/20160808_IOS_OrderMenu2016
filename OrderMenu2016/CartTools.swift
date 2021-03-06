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
    
    //设置一个新的购物车
    static func setCart(cart:CartModel)
    {
        let data:NSData = NSKeyedArchiver.archivedDataWithRootObject(cart)
        let sysDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        sysDefaults.setObject(data, forKey: "Cart")
        sysDefaults.synchronize()
    }
    
    //移除当前购物车
    static func removeCart()
    {
        sysDefaults.removeObjectForKey("Cart")
        sysDefaults.synchronize()
    }
    
    
    static func cartObj2Json()->String
    {
        let cart:CartModel = getCurrentCart()
        let dic:NSMutableDictionary = NSMutableDictionary(object: cart.CartId, forKey: "orderid")
        dic.setValue(cart.SeatNo, forKey: "SeatNo")
        dic.setValue(cart.PersonNum, forKey: "PersonNum")
        dic.setValue(cart.EmpNo, forKey: "EmpNo")
        dic.setValue("备注信息", forKey: "Memo")
        var arr:[[String]]=[]
        for it in cart.List
        {
            var tmpar:[String] = []
            tmpar.append(it.Item.OID)
            tmpar.append(it.Item.CName)
            tmpar.append(it.Item.Price1)
            tmpar.append(it.Item.Price1)
            tmpar.append(String(stringInterpolationSegment: it.Count))
            arr.append(tmpar)
        }
        dic.setValue(arr, forKey: "items")
        let jsonData:NSData = try! NSJSONSerialization.dataWithJSONObject(dic, options: NSJSONWritingOptions.PrettyPrinted)
        let s:NSString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)!
        return s as String
    }
}