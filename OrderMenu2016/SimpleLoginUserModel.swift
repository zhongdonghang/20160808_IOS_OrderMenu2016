//
//  SimpleLoginUserModel.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/8/8.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation

//登录用户返回对象
class SimpleLoginUserModel:NSObject,NSCoding {
    
   var  OID = ""
   var  Code = ""
   var  EmpNo = ""
   var  LoginName = ""
   var  RealName = ""
   var  UPass = ""
   var  UCategory = ""
   var  Gender = ""
   var  TelAndQQAndEmalOrOther = ""
   var  OrgID = ""
   var  DeletionStateCode = ""
   var  Enabled = ""
   var  SortCode = ""
   var  Description = ""
   var  CreateOn = ""
   var  CreateUserId = ""
   var  CreateBy = ""
   var  ModifiedOn = ""
   var  ModifiedUserId = ""
   var  ModifiedBy = ""
    
    init(LOGIN_NAME loginName:String)
    {
        self.LoginName = loginName
    }
    
    func encodeWithCoder(aCodeer:NSCoder){
        aCodeer.encodeObject(self.OID, forKey: "OID")
        aCodeer.encodeObject(self.Code, forKey: "Code")
        aCodeer.encodeObject(self.EmpNo, forKey: "EmpNo")
        aCodeer.encodeObject(self.LoginName, forKey: "LoginName")
        aCodeer.encodeObject(self.RealName, forKey: "RealName")
        aCodeer.encodeObject(self.UPass, forKey: "UPass")
        aCodeer.encodeObject(self.UCategory, forKey: "UCategory")
        aCodeer.encodeObject(self.Gender, forKey: "Gender")
        aCodeer.encodeObject(self.TelAndQQAndEmalOrOther, forKey: "TelAndQQAndEmalOrOther")
        aCodeer.encodeObject(self.OrgID, forKey: "OrgID")
        aCodeer.encodeObject(self.DeletionStateCode, forKey: "DeletionStateCode")
        aCodeer.encodeObject(self.Enabled, forKey: "Enabled")
        aCodeer.encodeObject(self.SortCode, forKey: "SortCode")
        aCodeer.encodeObject(self.Description, forKey: "Description")
        aCodeer.encodeObject(self.CreateOn, forKey: "CreateOn")
        aCodeer.encodeObject(self.CreateUserId, forKey: "CreateUserId")
        aCodeer.encodeObject(self.CreateBy, forKey: "CreateBy")
        aCodeer.encodeObject(self.ModifiedOn, forKey: "ModifiedOn")
        aCodeer.encodeObject(self.ModifiedUserId, forKey: "ModifiedUserId")
        aCodeer.encodeObject(self.ModifiedBy, forKey: "ModifiedBy")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.OID = aDecoder.decodeObjectForKey("OID") as! String
        self.Code = aDecoder.decodeObjectForKey("Code") as! String
        self.EmpNo = aDecoder.decodeObjectForKey("EmpNo") as! String
        self.LoginName = aDecoder.decodeObjectForKey("LoginName") as! String
        self.RealName = aDecoder.decodeObjectForKey("RealName") as! String
        self.UPass = aDecoder.decodeObjectForKey("UPass") as! String
        self.UCategory = aDecoder.decodeObjectForKey("UCategory") as! String
        self.Gender = aDecoder.decodeObjectForKey("Gender") as! String
        self.TelAndQQAndEmalOrOther = aDecoder.decodeObjectForKey("TelAndQQAndEmalOrOther") as! String
        self.OrgID = aDecoder.decodeObjectForKey("OrgID") as! String
         self.DeletionStateCode = aDecoder.decodeObjectForKey("DeletionStateCode") as! String
         self.Enabled = aDecoder.decodeObjectForKey("Enabled") as! String
         self.SortCode = aDecoder.decodeObjectForKey("SortCode") as! String
         self.Description = aDecoder.decodeObjectForKey("Description") as! String
         self.CreateOn = aDecoder.decodeObjectForKey("CreateOn") as! String
         self.CreateUserId = aDecoder.decodeObjectForKey("CreateUserId") as! String
         self.CreateBy = aDecoder.decodeObjectForKey("CreateBy") as! String
         self.ModifiedOn = aDecoder.decodeObjectForKey("ModifiedOn") as! String
         self.ModifiedUserId = aDecoder.decodeObjectForKey("ModifiedUserId") as! String
         self.ModifiedBy = aDecoder.decodeObjectForKey("ModifiedBy") as! String
    }
}
