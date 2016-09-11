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

    var F_Id = ""
    var F_Account = ""
    var F_RealName = ""
    var F_Gender = ""
    var F_Birthday = ""
    var F_MobilePhone = ""
    var F_OrganizeId = ""
    var F_DepartmentId = ""
    var F_RoleId = ""
    var F_DutyId = ""
    var F_IsAdministrator = ""
    var F_EnabledMark = ""
    var F_Description = ""
    var F_CreatorTime = ""
    var OrgNo = ""

    init(LOGIN_NAME loginName:String)
    {
        self.F_Account = loginName
    }
    
    func encodeWithCoder(aCodeer:NSCoder){
        aCodeer.encodeObject(self.F_Id, forKey: "F_Id")
        aCodeer.encodeObject(self.F_Account, forKey: "F_Account")
        aCodeer.encodeObject(self.F_RealName, forKey: "F_RealName")
        aCodeer.encodeObject(self.F_Gender, forKey: "F_Gender")
        aCodeer.encodeObject(self.F_Birthday, forKey: "F_Birthday")
        aCodeer.encodeObject(self.F_MobilePhone, forKey: "F_MobilePhone")
        aCodeer.encodeObject(self.F_OrganizeId, forKey: "F_OrganizeId")
        aCodeer.encodeObject(self.F_DepartmentId, forKey: "F_DepartmentId")
        aCodeer.encodeObject(self.F_RoleId, forKey: "F_RoleId")
        aCodeer.encodeObject(self.F_DutyId, forKey: "F_DutyId")
        aCodeer.encodeObject(self.F_IsAdministrator, forKey: "F_IsAdministrator")
        aCodeer.encodeObject(self.F_EnabledMark, forKey: "F_EnabledMark")
        aCodeer.encodeObject(self.F_Description, forKey: "F_Description")
        aCodeer.encodeObject(self.F_CreatorTime, forKey: "F_CreatorTime")
        aCodeer.encodeObject(self.OrgNo, forKey: "OrgNo")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.F_Id = aDecoder.decodeObjectForKey("F_Id") as! String
        self.F_Account = aDecoder.decodeObjectForKey("F_Account") as! String
        self.F_RealName = aDecoder.decodeObjectForKey("F_RealName") as! String
        self.F_Gender = aDecoder.decodeObjectForKey("F_Gender") as! String
        self.F_Birthday = aDecoder.decodeObjectForKey("F_Birthday") as! String
        self.F_MobilePhone = aDecoder.decodeObjectForKey("F_MobilePhone") as! String
        self.F_OrganizeId = aDecoder.decodeObjectForKey("F_OrganizeId") as! String
        self.F_DepartmentId = aDecoder.decodeObjectForKey("F_DepartmentId") as! String
        self.F_RoleId = aDecoder.decodeObjectForKey("F_RoleId") as! String
        self.F_DutyId = aDecoder.decodeObjectForKey("F_DutyId") as! String
         self.F_IsAdministrator = aDecoder.decodeObjectForKey("F_IsAdministrator") as! String
         self.F_EnabledMark = aDecoder.decodeObjectForKey("F_EnabledMark") as! String
         self.F_Description = aDecoder.decodeObjectForKey("F_Description") as! String
         self.F_CreatorTime = aDecoder.decodeObjectForKey("F_CreatorTime") as! String
         self.OrgNo = aDecoder.decodeObjectForKey("OrgNo") as! String
    }
}
