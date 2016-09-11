//
//  LoginView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/28.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SnapKit

protocol LoginOk {
    func UserLoginOk()
}

//登录视图
class LoginView: UIView {
    
     var delegate:LoginOk?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        setForm()
    }
    
     let  txtLoginName:UITextField = UITextField()
     let  txtLoginPass:UITextField = UITextField()
    
    func setForm() {
        let lbLoginName:UILabel = UILabel()
        lbLoginName.text = "账户:"
        lbLoginName.textColor = AppProductPriceTextColor
        self.addSubview(lbLoginName)
        lbLoginName.snp_makeConstraints { (make) in
            make.top.equalTo(30)
            make.left.equalTo(20)
        }
        
        txtLoginName.placeholder = "请输入注册手机号"
        txtLoginName.textAlignment = NSTextAlignment.Center
        txtLoginName.layer.cornerRadius = 10
        txtLoginName.font = UIFont.boldSystemFontOfSize(22)
        txtLoginName.layer.borderColor = AppProductPriceValueColor.CGColor
        txtLoginName.layer.borderWidth = 1
        self.addSubview(txtLoginName)
        txtLoginName.snp_makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(80)
            make.right.equalTo(-30)
            make.height.equalTo(40)
        }
        
        let lbLoginPass:UILabel = UILabel()
        lbLoginPass.text = "密码:"
        lbLoginPass.textColor = AppProductPriceTextColor

        self.addSubview(lbLoginPass)
        lbLoginPass.snp_makeConstraints { (make) in
            make.top.equalTo(90)
            make.left.equalTo(20)
        }
        
       
        txtLoginPass.placeholder = "请输入登录密码"
        txtLoginPass.secureTextEntry = true
        txtLoginPass.textAlignment = NSTextAlignment.Center
        txtLoginPass.font = UIFont.boldSystemFontOfSize(22)
        txtLoginPass.layer.cornerRadius = 10
        txtLoginPass.layer.borderColor = AppProductPriceValueColor.CGColor
        txtLoginPass.layer.borderWidth = 1
        self.addSubview(txtLoginPass)
        txtLoginPass.snp_makeConstraints { (make) in
            make.top.equalTo(80)
             make.left.equalTo(80)
            make.right.equalTo(-30)
             make.height.equalTo(40)
        }
        
        let btnLogin:UIButton = UIButton()
        btnLogin.layer.cornerRadius = 5
        btnLogin.backgroundColor = AppProductPriceValueColor
        btnLogin.setTitle("登录", forState: UIControlState.Normal)
        btnLogin.addTarget(self, action: #selector(LoginView.btnLoginClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btnLogin)
        btnLogin.snp_makeConstraints { (make) in
            make.top.equalTo(140)
            make.width.equalTo(200)
            make.centerX.equalTo(self)
        }
        
        let btnClose:UIButton = UIButton()
        btnClose.layer.cornerRadius = 5
        btnClose.backgroundColor = AppProductPriceTextColor
        btnClose.addTarget(self, action: #selector(LoginView.btnCloseClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnClose.setTitle("关闭", forState: UIControlState.Normal)
        self.addSubview(btnClose)
        btnClose.snp_makeConstraints { (make) in
            make.top.equalTo(200)
            make.width.equalTo(200)
            make.centerX.equalTo(self)
        }
    }
    
    func btnCloseClicked(sender:UIButton)
    {
        self.superview?.superview?.removeFromSuperview()
    }
    
    
    func btnLoginClicked(sender:UIButton)
    {
        if(self.txtLoginName.text == "")
        {
            ViewAlertTextCommon.ShowSimpleText("请输入登录名", view: self)
        }
        else if(self.txtLoginPass.text == "")
        {
            ViewAlertTextCommon.ShowSimpleText("请输入密码", view: self)
        }
        else
        {
            let parameters = [
                "loginName": "\(self.txtLoginName.text!)",
                "loginPass": "\(self.txtLoginPass.text!)"
            ]
            let url = AppServerURL1+"AppLoginV2"
            
            let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
            hud.label.text = "登录验证..."//showHUDAddedTo
           
            Alamofire.request(.GET, url,parameters: parameters).responseJSON { (response) in
                switch response.result {
                case.Success(let data):
                    let json = JSON(data)
                   
                    if(json["ResultCode"] == "200")//登录成功
                    {
                        /*
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
                         */
                        
                        let loginUser:SimpleLoginUserModel = SimpleLoginUserModel(LOGIN_NAME: "\(json["t"]["CurrentUser"]["F_Account"])")
                        
                        loginUser.F_Id = "\(json["t"]["CurrentUser"]["F_Id"])"
                        loginUser.F_RealName = "\(json["t"]["CurrentUser"]["F_RealName"])"
                        loginUser.F_Gender = "\(json["t"]["CurrentUser"]["F_Gender"])"
                        loginUser.F_Birthday = "\(json["t"]["CurrentUser"]["F_Birthday"])"
                        loginUser.F_MobilePhone = "\(json["t"]["CurrentUser"]["F_MobilePhone"])"
                        loginUser.F_OrganizeId = "\(json["t"]["CurrentUser"]["F_OrganizeId"])"
                        loginUser.F_DepartmentId = "\(json["t"]["CurrentUser"]["F_DepartmentId"])"
                        loginUser.F_RoleId = "\(json["t"]["CurrentUser"]["F_RoleId"])"
                        loginUser.F_DutyId = "\(json["t"]["CurrentUser"]["F_DutyId"])"
                        loginUser.F_IsAdministrator = "\(json["t"]["CurrentUser"]["F_IsAdministrator"])"
                        loginUser.F_EnabledMark = "\(json["t"]["CurrentUser"]["F_EnabledMark"])"
                        loginUser.F_Description = "\(json["t"]["CurrentUser"]["F_Description"])"
                        loginUser.F_CreatorTime = "\(json["t"]["CurrentUser"]["F_CreatorTime"])"
                        loginUser.OrgNo = "\(json["t"]["CurrentUser"]["OrgNo"])"
                        
                        //登录成功用户状态保存
                        let user:NSData = NSKeyedArchiver.archivedDataWithRootObject(loginUser)
                        let sysDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        sysDefaults.setObject(user, forKey: "LOGIN_USER")
                        sysDefaults.synchronize()
                        
                        self.delegate?.UserLoginOk()
                        
                        ViewAlertTextCommon.ShowSimpleText("登录成功", view: self)
                        self.superview?.superview?.removeFromSuperview()
                      
                    }else
                    {
                        let text = "\(json["Msg"])"
                        ViewAlertTextCommon.ShowSimpleText(text, view: self)
                    }
                case.Failure(let error):
                    let alert = UIAlertView(title: "错误消息", message: "异常:\(error)", delegate: self, cancelButtonTitle: "好")
                    alert.show()
                }
                hud.removeFromSuperview()
            }
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}