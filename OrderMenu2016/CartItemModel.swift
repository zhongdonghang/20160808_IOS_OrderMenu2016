//
//  CartItemModel.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/28.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation

class CartItemModel:NSObject,NSCoding {
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(self.Count, forKey: "Count")
        aCoder.encodeObject(self.Item, forKey: "Item")
        aCoder.encodeObject(self.IsSubmit, forKey: "IsSubmit")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        Count = aDecoder.decodeObjectForKey("Count") as! Double
        Item = aDecoder.decodeObjectForKey("Item") as! ProductSimpleViewModel
        IsSubmit = aDecoder.decodeObjectForKey("IsSubmit") as! String
    }
    
    override init()
    {
        
    }
    
    var Item:ProductSimpleViewModel = ProductSimpleViewModel()
    var Count:Double = 0
    var IsSubmit:String = "NO"
    
    var TotalPrice:Double
        {
        get
        {
            return (Item.Price1 as NSString).doubleValue * Count
        }
    }
}