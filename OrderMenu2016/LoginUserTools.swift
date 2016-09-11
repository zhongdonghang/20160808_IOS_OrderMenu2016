//
//  LoginUserTools.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/8/8.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation

//登录用户操作方法
class LoginUserTools {
    static let sysDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    //获取当前的门店编号
    static func getCurrentOrgId()->String
    {
        var ret = ""
        if(checkIsLogin())
        {
            ret = getLoginUser().OrgNo
        }
        else
        {
            ret = "20" //演示门店
        }
        return ret
    }
    
    //判断是否登录
    static func checkIsLogin() ->Bool
    {
        var isTrue = false
        if(sysDefaults.objectForKey("LOGIN_USER") != nil)
        {
            isTrue = true
        }
        return isTrue
    }
    
    //返回登录用户
    static func getLoginUser()->SimpleLoginUserModel
    {
        let data:NSData =  sysDefaults.objectForKey("LOGIN_USER") as! NSData
        let user:SimpleLoginUserModel = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! SimpleLoginUserModel
        return user
    }
    
    
    static func LoginOut()
    {
        sysDefaults.removeObjectForKey("LOGIN_USER")
        sysDefaults.synchronize()
    }

}