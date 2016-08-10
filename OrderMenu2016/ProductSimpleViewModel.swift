//
//  ProductSimpleViewModel.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/26.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation
/*商品模型*/
class ProductSimpleViewModel:NSObject,NSCoding {
    var OID = ""
    var CName = ""
    var Price1 = ""
    var Price2 = ""
    var PIngredients = ""
    var PContent = ""
    var PPractice = ""
    var ImgName = ""
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(self.OID, forKey: "OID")
        aCoder.encodeObject(self.CName, forKey: "CName")
        aCoder.encodeObject(self.Price1, forKey: "Price1")
        aCoder.encodeObject(self.Price2, forKey: "Price2")
        aCoder.encodeObject(self.PIngredients, forKey: "PIngredients")
        aCoder.encodeObject(self.PContent, forKey: "PContent")
        aCoder.encodeObject(self.PPractice, forKey: "PPractice")
        aCoder.encodeObject(self.ImgName, forKey: "ImgName")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        OID = aDecoder.decodeObjectForKey("OID") as! String
        CName = aDecoder.decodeObjectForKey("CName") as! String
        Price1 = aDecoder.decodeObjectForKey("Price1") as! String
        Price2 = aDecoder.decodeObjectForKey("Price2") as! String
        PIngredients = aDecoder.decodeObjectForKey("PIngredients") as! String
        PContent = aDecoder.decodeObjectForKey("PContent") as! String
        PPractice = aDecoder.decodeObjectForKey("PPractice") as! String
        ImgName = aDecoder.decodeObjectForKey("ImgName") as! String
    }
    
    override init()
    {
        
    }
}