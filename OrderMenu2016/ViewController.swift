//
//  ViewController.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/19.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit
import SnapKit

//演示门店编号
let DEMO_ORG_ID = "20"
//当前登录的门店编号
let CURRENT_ORG_ID = "CURRENT_ORG_ID"

/*
 接口路径1,包含了绝大多数业务接口方法
 */
let AppServer = "http://1.nnbetter.com:8029/"
let AppServerURL = "http://1.nnbetter.com:8029/api/appapi.asmx/"

/*
   接口路径2,包含登录，注册，获取注册门店的门店类型列表方法
 */
let AppServerURL1 = "http://1.nnbetter.com:8029/api/appapi11.asmx/"

//app启动首页
class ViewController: UIViewController,UIAlertViewDelegate,ILoginOkSetting {

    //app启动首页，中心图片的视图，启动该图会由上至下到中心区域的效果
    lazy var centerView: SpringView = {
        let centerView = SpringView()
        centerView.backgroundColor = UIColor.clearColor()
        return centerView
    }()
    
    //点击页面“设置”按钮，启动的视图容器，视图包含注册，登录，使用说明的介绍
    lazy var settingViewContainer: SpringView = {
        let settingViewContainer = SpringView()
        return settingViewContainer
    }()
    
    //封面中心图片视图
    let centerImgView = UIImageView(image: UIImage(named: "fengmian_1"))
    //弹出选择窗用用户选择“登录/注册”或者“演示门店”
    let selectAlertView = UIAlertView();
    
    //预加载事件方法
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setCenterView()
    }
    
    //视图加载事件方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setInitView()
        setInputButton()
        setOpenView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //初始化封面视图方法
    func setInitView() {
        let bgView:UIImageView = UIImageView(image: UIImage(named: "fengmian_0"))
        self.view.addSubview(bgView)
        bgView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(20)
        }
    }
    
    //初始化封面中心图片的方法，定义了由上至下的动画效果
    func setCenterView()  {
        view.addSubview(centerView)
       
        centerView.addSubview(centerImgView)
        centerImgView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(-40)
            make.width.equalTo(251)
            make.height.equalTo(294)
        }
        centerView.animation = "squeezeDown"
        centerView.curve = "easeIn"
        centerView.duration = 1
        centerView.snp_makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.equalTo(251)
            make.height.equalTo(294)
        }
        centerView.animate()
    }
    
    //初始化封面右侧上方按钮的方法，“关于”，“设置”，“样板店”，"进入点菜"
    func setInputButton() {
        // “关于”按钮定义开始
        let btnAbout:UIButton = UIButton()
        btnAbout.setBackgroundImage(UIImage(named: "aboutme"), forState: UIControlState.Normal)
        self.view.addSubview(btnAbout)
        btnAbout.snp_makeConstraints { (make) in
            make.right.equalTo(-1)
            make.top.equalTo(60)
            make.width.equalTo(107)
            make.height.equalTo(36)
        }
        // “关于”按钮定义结束
        
        //“设置”按钮定义开始
        let btnSetting:UIButton = UIButton()
        btnSetting.setBackgroundImage(UIImage(named: "setting"), forState: UIControlState.Normal)
        btnSetting.addTarget(self, action: #selector(ViewController.btnSettingClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnSetting)
        btnSetting.snp_makeConstraints { (make) in
            make.right.equalTo(-1)
            make.top.equalTo(120)
            make.width.equalTo(108)
            make.height.equalTo(36)
        }
        //“设置按钮定义结束”
        
        
        // “进入点菜“ 按钮定义开始
        let btnIn:UIButton = UIButton()
        btnIn.setBackgroundImage(UIImage(named: "fengmian_2"), forState: UIControlState.Normal)
        btnIn.addTarget(self, action: #selector(ViewController.btnInClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnIn)
        btnIn.snp_makeConstraints { (make) in
                    make.right.equalTo(-1)
                    make.top.equalTo(240)
                    make.width.equalTo(106)
                    make.height.equalTo(34)
        }
         // “进入点菜“ 按钮定义结束
    }
    
    //定义”进入点菜“的操作区域，支持左滑，右滑，单击等手势
    func setOpenView()  {
        //定义手势区域开始
        let v = UIView()
        v.backgroundColor = UIColor.clearColor()
        self.view.addSubview(v)
        v.snp_makeConstraints { (make) in
            make.bottom.equalTo(-100)
            make.top.equalTo(500)
            make.left.equalTo(300)
            make.right.equalTo(-300)
        }
        //定义手势区域结束
        
        //右滑手势
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipeGesture(_:)))
        v.addGestureRecognizer(swipeGesture)
        
        //左划手势
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipeGesture(_:)))
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Left //不设置是右
        v.addGestureRecognizer(swipeLeftGesture)
        
        //点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTapGesture))
        v.addGestureRecognizer(tapGesture)
    }
    
    //手势操作进入点菜的方法
    func handleTapGesture() {
        goOrder()
    }
    
    //划动手势
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
        goOrder()
    }

    //点击右上角进入点菜的按钮事件方法
    func btnInClicked(sender:UIButton) {
        goOrder()
    }
    
    //进入点菜的方法
    func goOrder()  {
        if(LoginUserTools.checkIsLogin())
        {
            centerView.animation = "zoomOut"
            centerView.curve = "easeInOut"
            centerView.duration = 0.3
            centerView.snp_makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.equalTo(251)
            make.height.equalTo(294)
            }
            centerView.animateToNext {
            self.navigationController?.pushViewController(MainViewController(), animated: true)
            }
        }else
        {
            selectAlertView.delegate = self
            selectAlertView.message = "您尚未登录，请登录或者选择进入演示门店"
            selectAlertView.title = "提示"
            selectAlertView.addButtonWithTitle("前往登录")
            selectAlertView.addButtonWithTitle("样板店演示")
            selectAlertView.show()
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(buttonIndex == 0) //前往登录
        {
            goLoginOrReg()
        }
        else if(buttonIndex == 1) //样板店
        {
            self.navigationController?.pushViewController(MainViewController(), animated: true)
        }
    }
    

//    //登录成功执行的方法
//    func UserLoginOk()
//    {
//        print("UserLoginOk")
//       // self.navigationController!.pushViewController(MainViewController(), animated: true)
//
//    }
     func loginOkSetting()
     {
         print("UserLoginOk")
     }
    
    
    //设置按钮
    func btnSettingClicked(sender:UIButton) {
        goLoginOrReg()
    }
    
    func settingViewContainerHide() {
        settingViewContainer.removeFromSuperview()
    }
    
    //前往设置界面 ，登录或者注册
    func goLoginOrReg() {
        self.view.addSubview(settingViewContainer)
        let objSettingView:SettingView = SettingView(frame: CGRectMake(0, 0, 0, 0))
        settingViewContainer.addSubview(objSettingView)
        objSettingView.snp_makeConstraints { (make) in
            make.centerX.equalTo(settingViewContainer)
            make.top.equalTo(30)
            make.width.equalTo(500)
            make.height.equalTo(600)
        }
        
        settingViewContainer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        settingViewContainer.animation = "squeezeDown"
        settingViewContainer.curve = "easeIn"
        settingViewContainer.duration = 0.3
        settingViewContainer.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        settingViewContainer.animate()
    }
}

