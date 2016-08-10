//
//  CartModel.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/28.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation

//购物车模型
class CartModel:NSObject,NSCoding {
    //购物车号(订单号)
    var CartId:String!
    //座位号
    var SeatNo:String!
    //人数
    var PersonNum:Int!
    //员工号（服务员）
    var EmpNo:String!
    //购物车清单列表
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
    

    //当前购物车总金额
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
    
    //清空购物车
    func clearCart()
    {
        List.removeAll(keepCapacity: true)
    }
    
    //移除某项商品
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
    
    //某项商品数量减1
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
    
    //增加某个商品（如果没有则增加，如果有则加1）
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