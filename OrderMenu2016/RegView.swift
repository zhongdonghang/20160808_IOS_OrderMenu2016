//
//  RegView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/28.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SnapKit

//注册视图
class ReginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        setForm()
    }
    let  txtFullName:UITextField = UITextField()
    let  txtLoginName:UITextField = UITextField()
    let  txtAdminName:UITextField = UITextField()
    
    func setForm() {
        
        let lbFullName:UILabel = UILabel()
        lbFullName.text = "门店全称:"
        lbFullName.textColor = AppProductPriceTextColor
        self.addSubview(lbFullName)
        lbFullName.snp_makeConstraints { (make) in
            make.top.equalTo(30)
            make.left.equalTo(20)
        }
        
        
        txtFullName.placeholder = "请输入门店全称"
        txtFullName.textAlignment = NSTextAlignment.Center
        txtFullName.layer.cornerRadius = 5
        txtFullName.font = UIFont.boldSystemFontOfSize(22)
        txtFullName.layer.borderColor = AppProductPriceValueColor.CGColor
        txtFullName.layer.borderWidth = 1
        self.addSubview(txtFullName)
        txtFullName.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(100)
            make.height.equalTo(40)
            make.right.equalTo(-20)
        }
        
        let lbLoginName:UILabel = UILabel()
        lbLoginName.text = "管理账号:"
        lbLoginName.textColor = AppProductPriceTextColor
        self.addSubview(lbLoginName)
        lbLoginName.snp_makeConstraints { (make) in
            make.top.equalTo(90)
            make.left.equalTo(20)
        }
        
       
        txtLoginName.placeholder = "输入手机号作为账号"
        txtLoginName.textAlignment = NSTextAlignment.Center
        txtLoginName.layer.cornerRadius = 5
        txtLoginName.font = UIFont.boldSystemFontOfSize(22)
        txtLoginName.layer.borderColor = AppProductPriceValueColor.CGColor
        txtLoginName.layer.borderWidth = 1
        self.addSubview(txtLoginName)
        txtLoginName.snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(100)
            make.height.equalTo(40)
            
            make.right.equalTo(-20)
        }
        
        let lbAdminName:UILabel = UILabel()
        lbAdminName.text = "您的大名:"
        lbAdminName.textColor = AppProductPriceTextColor
        self.addSubview(lbAdminName)
        lbAdminName.snp_makeConstraints { (make) in
            make.top.equalTo(150)
            make.left.equalTo(20)
        }
        
       
        txtAdminName.layer.cornerRadius = 10
        txtAdminName.placeholder = "请输入您的大名"
        
        txtAdminName.textAlignment = NSTextAlignment.Center
        txtAdminName.layer.cornerRadius = 5
        txtAdminName.font = UIFont.boldSystemFontOfSize(22)
        txtAdminName.layer.borderColor = AppProductPriceValueColor.CGColor
        txtAdminName.layer.borderWidth = 1
        
        self.addSubview(txtAdminName)
        txtAdminName.snp_makeConstraints { (make) in
            make.top.equalTo(140)
            make.left.equalTo(100)
            make.height.equalTo(40)
            make.right.equalTo(-20)
        }
        
        let btnReg:UIButton = UIButton()
        btnReg.layer.cornerRadius = 5
        btnReg.backgroundColor = AppProductPriceValueColor
        btnReg.setTitle("注册", forState: UIControlState.Normal)
        btnReg.addTarget(self, action: #selector(ReginView.btnRegClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btnReg)
        btnReg.snp_makeConstraints { (make) in
            make.top.equalTo(190)
            make.width.equalTo(200)
            make.centerX.equalTo(self).offset(30)
        }
        
        let btnClose:UIButton = UIButton()
        btnClose.layer.cornerRadius = 5
        btnClose.backgroundColor = AppProductPriceTextColor
        btnClose.addTarget(self, action: #selector(ReginView.btnCloseClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnClose.setTitle("关闭", forState: UIControlState.Normal)
        self.addSubview(btnClose)
        btnClose.snp_makeConstraints { (make) in
            make.top.equalTo(250)
            make.width.equalTo(200)
            make.centerX.equalTo(self).offset(30)
        }
    }

    func btnRegClicked(sender:UIButton)
    {
        if(self.txtFullName.text == "")
        {
            ViewAlertTextCommon.ShowSimpleText("请输入门店名字", view: self)
        } else if(self.txtLoginName.text == "")
        {
            ViewAlertTextCommon.ShowSimpleText("请输入手机号码作为账号", view: self)
        }else if(self.txtAdminName.text == "")
        {
            ViewAlertTextCommon.ShowSimpleText("请输入您的大名", view: self)
        }
        else
        {
            let url = AppServerURL1+"AppReg"
            let parameters = [
                "ShortName": "\(self.txtFullName.text!)",
                "FullName":"\(self.txtFullName.text!)",
                "MemberNum":"50人以下",
                "SeatNum":"100",
                "Desc":"暂无",
                "OrgCategory":"2",
                "Tel":"\(self.txtLoginName.text!)",
                 "LoginName":"\(self.txtLoginName.text!)",
                 "RealName":"\(self.txtAdminName.text!)",
                 "UPass":"123456",
                 "Gender":"男",
                 "TelAndQQAndEmalOrOther":"暂无",
                   "Description":"暂无"
            ]
            print(parameters)
            let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
            hud.label.text = "努力加载数据中..."
            
            Alamofire.request(.POST, url,parameters: parameters).responseJSON { (response) in
                switch response.result {
                case.Success(let data):
                    let json = JSON(data)
                    print("\(json)")
                    if(json["ResultCode"] == "200")//请求成功
                    {
                        ViewAlertTextCommon.ShowSimpleTextWith3("开通门店成功,密码是123456，请阅读使用说明", view: self)
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
    
    func btnCloseClicked(sender:UIButton)
    {
        self.superview?.superview?.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}