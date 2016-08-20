//
//  SettingView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/26.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit

protocol ILoginOkSetting {
    func loginOkSetting()
}

//封面设置视图，登录，注册
class SettingView: UIView,LoginOk {
    
    var delgateILoginOkSetting:ILoginOkSetting!

    let loginView:LoginView = LoginView(frame: CGRectMake(0, 0, 0, 0))
    let regView:ReginView = ReginView(frame: CGRectMake(0, 0, 0, 0))
    let objOpeateDescView:OpeateDescView = OpeateDescView(frame: CGRectMake(0, 0, 0, 0))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 10
       
        let items=["账户登录","新账户注册","使用说明"]
        let seg: UISegmentedControl = UISegmentedControl(items: items)
        seg.selectedSegmentIndex = 2
         seg.tintColor = AppProductPriceValueColor
        seg.addTarget(self, action: #selector(SettingView.segmentDidchange(_:)),
                            forControlEvents: UIControlEvents.ValueChanged)  //添加值改变监听
        self.addSubview(seg)
        seg.snp_makeConstraints { (make) in
            make.top.equalTo(30)
            make.centerX.equalTo(self)
        }
        setDescView()
    }
    
    func segmentDidchange(segmented:UISegmentedControl){
        regView.removeFromSuperview()
        loginView.removeFromSuperview()
        objOpeateDescView.removeFromSuperview()
        if(segmented.selectedSegmentIndex == 0) //登录
        {

            self.addSubview(loginView)
            loginView.snp_makeConstraints(closure: { (make) in
                make.width.equalTo(400)
                make.centerX.equalTo(self)
                make.top.equalTo(70)
                make.bottom.equalTo(0)
            })
        }else if(segmented.selectedSegmentIndex == 1) //注册
        {
            self.addSubview(regView)
            regView.snp_makeConstraints(closure: { (make) in
                make.width.equalTo(400)
                make.centerX.equalTo(self)
                make.top.equalTo(70)
                make.bottom.equalTo(0)
            })
        }
        else if(segmented.selectedSegmentIndex == 2) //说明
        {
            setDescView()
        }
    }
    
    func setDescView()  {
        self.addSubview(objOpeateDescView)
        objOpeateDescView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-5)
        })
    }
    
    func UserLoginOk()
    {
        delgateILoginOkSetting.loginOkSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
