//
//  CartModel.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/28.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation

//class SerialNumber {
//    
//    class func getNumber()->String
//    {
//        let sysDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//        var n:Int = 0
//        if sysDefaults.objectForKey("CartId") == nil
//        {
//            sysDefaults.setInteger(1001, forKey: "CartId")
//            n=1001
//        }
//        else
//        {
//            n = sysDefaults.integerForKey("CartId")
//            n += 1
//        }
//        return String(n)
//    }
//    
//}

class CartModel:NSObject,NSCoding {
    var CartId:String!
    var SeatNo:String!
    var PersonNum:Int!
    var EmpNo:String!
    var List:[CartItemModel]!
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(self.CartId, forKey: "CartId")
        aCoder.encodeObject(self.SeatNo, forKey: "SeatNo")
        aCoder.encodeObject(self.PersonNum, forKey: "PersonNum")
        aCoder.encodeObject(self.EmpNo, forKey: "EmpNo")
        aCoder.encodeObject(self.List, forKey: "List")
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        CartId = aDecoder.decodeObjectForKey("CartId") as! String
        SeatNo = aDecoder.decodeObjectForKey("SeatNo") as! String
        PersonNum = aDecoder.decodeObjectForKey("PersonNum") as! Int
        EmpNo = aDecoder.decodeObjectForKey("EmpNo") as! String
        List = aDecoder.decodeObjectForKey("List") as! [CartItemModel]
        
    }
    
    init(OrderId orderid:String,SeatNo no:String,PersonNum num:Int,EmpNo emp:String)
    {
        self.CartId = orderid
        self.SeatNo = no
        self.PersonNum = num
        self.EmpNo = emp
        self.List=[]
    }
    

    
    var TotalMoney:Double
        {
        get
        {
            var result = 0.0
            for it in List
            {
                result += it.TotalPrice
            }
            return result
        }
    }
    
    func clearCart()
    {
        List.removeAll(keepCapacity: true)
    }
    
    func removeItem(RemoveProduct p:ProductSimpleViewModel)->Bool
    {
        var result:Bool = false
        var index:Int = 0
        for it in List
        {
            if it.Item.OID == p.OID
            {
                it.Count = it.Count-1
                result = true
                break
            }
            index += 1
        }
        List.removeAtIndex(index)
        return result
    }
    
    func removeProductOne(RemoveProduct p:ProductSimpleViewModel)->Bool
    {
        var result:Bool = false
        var index:Int = 0
        for it in List
        {
            if it.Item.OID == p.OID
            {
                it.Count = it.Count-1
                result = true
                break
            }
            index += 1
        }
        
        if(!result)
        {
            return result
        }
        
        if(List[index].Count==0)
        {
            List.removeAtIndex(index)
        }
        return result
    }
    
    func addProduct(AddProduct p:ProductSimpleViewModel)->Bool
    {
        var result:Bool = false
        for it in List
        {
            if it.Item.OID == p.OID
            {
                it.Count = it.Count+1
                result = true
                break
            }
        }
        if(!result)
        {
            let cartItem:CartItemModel = CartItemModel()
            cartItem.Count=1
            cartItem.Item = p
            List.append(cartItem)
            result = true
        }
        return result
    }
    
}