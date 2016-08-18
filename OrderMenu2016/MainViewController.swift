//
//  MainViewController.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/20.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit
import SnapKit

let AppMainBgColor = UIColor(red: 255/255, green: 249/255, blue: 233/255, alpha: 1)
let AppLeftMenuBgColor = UIColor(red: 252/255, green: 231/255, blue: 148/255, alpha: 1)
let AppLineBgColor = UIColor(red: 115/255, green: 35/255, blue: 26/255, alpha: 1)
let AppLeftMenuSelectBgColor = UIColor(red: 230/255, green: 51/255, blue: 26/255, alpha: 1)
let AppDetailsProductBgColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
let AppProductPriceTextColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
let AppProductPriceValueColor = UIColor(red: 230/255, green: 51/255, blue: 26/255, alpha: 1)


class MainViewController: UIViewController,LeftMenuClicked,ProductClicked,CartNotExist,UIPopoverPresentationControllerDelegate,ISelectFuWuYuan,IFuWuYuanChecked,UIAlertViewDelegate {

    
    
    //菜品明细视图
    lazy var detailsViewContainer: SpringView = {
        let detailsViewContainer = SpringView()
        return detailsViewContainer
    }()
    
    //开单视图容器(选座位，服务员)
    lazy var openOrderViewViewContainer: SpringView = {
        let openOrderViewViewContainer = SpringView()
        return openOrderViewViewContainer
    }()
    
    //主列表视图
    lazy var listViewContainer: SpringView = {
        let listViewContainer = SpringView()
        return listViewContainer
    }()
    
    //购物车视图
    lazy var CartViewContainer: SpringView = {
        let CartViewContainer = SpringView()
        return CartViewContainer
    }()
    
    //订单列表视图
    lazy var OrderListViewContainer: SpringView = {
        let OrderListViewContainer = SpringView()
        return OrderListViewContainer
    }()
    
    var objOpenOrderView:OpenOrderView!
    var objMainRightMenuView:MainRightMenuView!
    var objDetailsView:DetailsView!
    
    let isNewOrderAlertView:UIAlertView = UIAlertView()
    let isTuiChuAlertView:UIAlertView = UIAlertView()
    
    //选中左侧菜单后执行的方法
    func menuSelected(menuId:String)
    {
        detailsViewContainer.removeFromSuperview()
        if(objMainRightMenuView != nil)
        {
            objMainRightMenuView.removeFromSuperview()
        }
        objMainRightMenuView = MainRightMenuView(frame:  CGRectMake(0, 0, self.view.bounds.width-180, self.view.bounds.height-30),menuid: menuId)
        
        //点击商品显示详情的委托
        objMainRightMenuView.delegateProductSelected = self
        
        //开新单（选座位，选服务员）的委托
        objMainRightMenuView.delegateNewCart = self
        
        //选中左边类别后右边刷新菜品列表
        listViewContainer.addSubview(objMainRightMenuView)
        listViewContainer.animation = "zoomIn"
        listViewContainer.backgroundColor = UIColor.clearColor()
        listViewContainer.curve = "easeIn"
        listViewContainer.duration = 0.4
        self.view.addSubview(listViewContainer)
        listViewContainer.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(170)
            make.width.equalTo(self.view.bounds.width-180)
            make.height.equalTo(self.view.bounds.height-30)
        }
        listViewContainer.animate()
    }
    
    //窗体加载事件
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseView()
        setLeftMenuTable()
        setButtons()
    }
    
    //商品详细视图移除
    func detailsViewHide() {
        detailsViewContainer.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBaseView() {
        self.view.backgroundColor = AppMainBgColor
        let leftMenuBgView:UIView = UIView()
        leftMenuBgView.backgroundColor = AppLeftMenuBgColor
        self.view.addSubview(leftMenuBgView)
        leftMenuBgView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(150)
        }
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.detailsViewHide))
        leftMenuBgView.addGestureRecognizer(tapGesture)
        
        let leftMenuLineBgView:UIView = UIView()
        leftMenuLineBgView.backgroundColor = AppLineBgColor
        self.view.addSubview(leftMenuLineBgView)
        leftMenuLineBgView.snp_makeConstraints { (make) in
            make.left.equalTo(150)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(2)
        }
    }
    
    func setLeftMenuTable()  {
        let objMainLeftMenuView:MainLeftMenuView = MainLeftMenuView(frame: CGRectMake(0, 10, 150, 500) )
        objMainLeftMenuView.delegate = self
        self.view.addSubview(objMainLeftMenuView)
    }
    
    func setButtons()  {

        //购物车（已点）按钮
        let btnCart = UIButton()
        btnCart.setBackgroundImage(UIImage(named: "main_yidian"), forState: UIControlState.Normal)
        btnCart.addTarget(self, action: #selector(MainViewController.btnCartClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnCart)
        btnCart.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.bottom.equalTo(-180)
            make.width.equalTo(137)
            make.height.equalTo(44)
        }
        
        //开单按钮（选座位，选服务员）
        let btnRenShu = UIButton()
        btnRenShu.setBackgroundImage(UIImage(named: "renshu"), forState: UIControlState.Normal)
        btnRenShu.addTarget(self, action: #selector(MainViewController.btnRenShuClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnRenShu)
        btnRenShu.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(-130)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        
        //进行中订单的按钮
        let btnOrders = UIButton()
        btnOrders.setBackgroundImage(UIImage(named: "daifa"), forState: UIControlState.Normal)
        btnOrders.addTarget(self, action: #selector(MainViewController.btnOrdersClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnOrders)
        btnOrders.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(-80)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        
        //退出按钮
        let btnTuiChu = UIButton()
        btnTuiChu.setBackgroundImage(UIImage(named: "tuichu"), forState: UIControlState.Normal)
        btnTuiChu.addTarget(self, action: #selector(MainViewController.btnTuiChuClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnTuiChu)
        btnTuiChu.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(-30)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
    }
    
    
    func btnTuiChuClicked(sender:UIButton)  {
        
        isTuiChuAlertView.delegate = self
        isTuiChuAlertView.tag = 2
        isTuiChuAlertView.message = "退出将会清空当前购物车的数据，确定吗"
        isTuiChuAlertView.title = "提示"
        isTuiChuAlertView.addButtonWithTitle("是的")
        isTuiChuAlertView.addButtonWithTitle("不要")
        isTuiChuAlertView.show()
        
       
    }
    
    
    func ProductSelected(product:ProductSimpleViewModel)
    {
        
        view.addSubview(detailsViewContainer)
        
        objDetailsView = DetailsView(frame: CGRectMake(254, 0, 620, 768), product: product)
        //objDetailsView.delgateCurrentCartNotExist = self
        detailsViewContainer.addSubview(objDetailsView)
        
        let btnCloseContainer = UIButton()
        btnCloseContainer.backgroundColor = UIColor.clearColor()
        detailsViewContainer.addSubview(btnCloseContainer)
        btnCloseContainer.addTarget(self, action: #selector(MainViewController.btnCloseContainerClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnCloseContainer.snp_makeConstraints { (make) in
            make.width.equalTo(254)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        
        detailsViewContainer.animation = "squeezeLeft"
        detailsViewContainer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        detailsViewContainer.curve = "easeIn"
        detailsViewContainer.duration = 0.4
        detailsViewContainer.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(150)
        }
        detailsViewContainer.animate()
    }
    
    func btnCloseContainerClicked(sender:UIButton) {
        detailsViewContainer.removeFromSuperview()
    }
    
    func btnCloseOpenOrderViewContainerClicked(sender:UIButton) {
        openOrderViewViewContainer.removeFromSuperview()
    }
    
    
    //点击开单按钮
    func btnRenShuClicked(sender:UIButton) {
        if(CartTools.checkCartIsExist())
        {
            isNewOrderAlertView.delegate = self
            isNewOrderAlertView.tag = 1
            isNewOrderAlertView.message = "当前购物车尚未结束，确定要重新开一个新的购物车吗"
            isNewOrderAlertView.title = "提示"
            isNewOrderAlertView.addButtonWithTitle("是的")
            isNewOrderAlertView.addButtonWithTitle("不要")
            isNewOrderAlertView.show()

        }else{
            showNewCarView()
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(alertView.tag==1)
        {
            if(buttonIndex==0) //是得
            {
                showNewCarView()
            }
        }
        if(alertView.tag==2) //清空购物车，退出到首页
        {
            if(buttonIndex==0) //是得
            {
                CartTools.removeCart()
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    //打开购物车
    func  btnCartClicked(sender:UIButton) {
        if(CartTools.checkCartIsExist())
        {
            view.addSubview(CartViewContainer)
            let objCartView:CartView = CartView(frame: CGRectMake(400, 0, 624, 768))
            // objOpenOrderView.delegate = self
            CartViewContainer.addSubview(objCartView)
            
            let btnCloseCartViewContainer = UIButton()
            btnCloseCartViewContainer.backgroundColor = UIColor.clearColor()
            CartViewContainer.addSubview(btnCloseCartViewContainer)
            btnCloseCartViewContainer.addTarget(self, action: #selector(MainViewController.btnCloseCartViewContainerClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            btnCloseCartViewContainer.snp_makeConstraints { (make) in
                make.width.equalTo(400)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
                make.left.equalTo(0)
            }
            
            CartViewContainer.animation = "squeezeLeft"
            CartViewContainer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            CartViewContainer.curve = "easeIn"
            CartViewContainer.duration = 0.4
            CartViewContainer.snp_makeConstraints { (make) in
                make.right.equalTo(0)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
                make.left.equalTo(0)
            }
            CartViewContainer.animate()
        }else{
            ViewAlertTextCommon.ShowSimpleText("当前尚无购物车，请开新单", view: self.view)
        }

    }
    
    func btnOrdersClicked(sender:UIButton){
        view.addSubview(OrderListViewContainer)
        
        let objOrderListView:OrderListView = OrderListView(frame: CGRectMake(400, 0, 624, 768))
        // objOpenOrderView.delegate = self
        OrderListViewContainer.addSubview(objOrderListView)
        
        let btnCloseOrderListViewContainer = UIButton()
        btnCloseOrderListViewContainer.backgroundColor = UIColor.clearColor()
        OrderListViewContainer.addSubview(btnCloseOrderListViewContainer)
        btnCloseOrderListViewContainer.addTarget(self, action: #selector(MainViewController.btnCloseOrderListViewContainerClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnCloseOrderListViewContainer.snp_makeConstraints { (make) in
            make.width.equalTo(400)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        
        OrderListViewContainer.animation = "squeezeLeft"
        OrderListViewContainer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        OrderListViewContainer.curve = "easeIn"
        OrderListViewContainer.duration = 0.4
        OrderListViewContainer.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        OrderListViewContainer.animate()
    }
    
    func btnCloseCartViewContainerClicked(sender:UIButton) {
         CartViewContainer.removeFromSuperview()
    }
    
    func btnCloseOrderListViewContainerClicked(sender:UIButton) {
        OrderListViewContainer.removeFromSuperview()
    }
    
    //新开单方法（协议方法）
    func newCart()
    {
        showNewCarView()
    }
    

    //显示开单视图（人数/服务员/台位）
    func  showNewCarView() {
        view.addSubview(openOrderViewViewContainer)
        
        objOpenOrderView = OpenOrderView(frame: CGRectMake(151, 0, 873, 768) )
         objOpenOrderView.delgateSelectFuWuYuan = self
        openOrderViewViewContainer.addSubview(objOpenOrderView)
        let btnCloseOpenOrderViewContainer = UIButton()
        btnCloseOpenOrderViewContainer.backgroundColor = UIColor.clearColor()
        openOrderViewViewContainer.addSubview(btnCloseOpenOrderViewContainer)
        btnCloseOpenOrderViewContainer.addTarget(self, action: #selector(MainViewController.btnCloseOpenOrderViewContainerClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnCloseOpenOrderViewContainer.snp_makeConstraints { (make) in
            make.width.equalTo(150)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        
        openOrderViewViewContainer.animation = "squeezeLeft"
        openOrderViewViewContainer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        openOrderViewViewContainer.curve = "easeIn"
        openOrderViewViewContainer.duration = 0.4
        openOrderViewViewContainer.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        openOrderViewViewContainer.animate()
        
    }
    
    //打开服务员选择的浮动窗口
    func selectFuWuYuan(textField: UITextField,empAr:[EmpModel])
     {
        let pop = PopoverController()
        pop.delgateIFuWuYuanChecked = self
        pop.empAr = empAr
        pop.modalPresentationStyle = .Popover
        pop.popoverPresentationController?.delegate = self
        pop.popoverPresentationController?.sourceView = textField
        pop.popoverPresentationController?.sourceRect = CGRectZero
        self.presentViewController(pop, animated: true, completion: nil)
    }
    
    //选中服务员的回调方法
    func FuWuYuanChecked(emp:EmpModel)
    {
        objOpenOrderView.txtFuWuYuan.text = emp.Cname
    }
}
