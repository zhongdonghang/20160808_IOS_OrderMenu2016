//
//  OpeateDescView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/28.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import Foundation

class OpeateDescView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        let lbText:UILabel = UILabel()
        lbText.numberOfLines = 0
        lbText.textColor = AppProductPriceTextColor
        lbText.textAlignment = NSTextAlignment.Justified
        lbText.font = UIFont.boldSystemFontOfSize(17)
        lbText.text = "注册说明：\n    1:使用前先注册账户 \n    2:注册请完整输入门店名称，登录手机号和您的大名\n    3:注册成功后默认密码是123456，请登录管理后台进行修改\n    4:注册成功后，请使用手机号登录管理后台（http://121.40.81.12:8029/system/login.aspx）进行菜单管理等操作 \n登录说明 \n    1:使用注册的手机号进行登录\n    2:一般使用只用登录一次，除非重新删除安装app，否则不用重新登录\n    3:忘记密码请联系运营方进行密码重置 \n样板店说明\n    1:直接首页点击样板店登录\n    2:样板店管理后台（http://121.40.81.12:8029/system/login.aspx）请使用账户ylfd_admin，密码123456进行登录可以查看样板店的数据样板。\n运维联系方式：\n    负责人:钟东航 \n    手机：18577011009 \n    邮箱：235952254@qq.com  \n    qq号：235952254"
        self.addSubview(lbText)
        lbText.snp_makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.left.equalTo(2)
            make.right.equalTo(-2)
            make.top.equalTo(-20)
        }

        let btnClose:UIButton = UIButton()
        btnClose.layer.cornerRadius = 5
        btnClose.backgroundColor = AppProductPriceTextColor
        btnClose.addTarget(self, action: #selector(LoginView.btnCloseClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnClose.setTitle("关闭", forState: UIControlState.Normal)
        self.addSubview(btnClose)
        btnClose.snp_makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.width.equalTo(200)
            make.centerX.equalTo(self)
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