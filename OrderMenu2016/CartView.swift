//
//  CartView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/23.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import SnapKit

class CartView: UIView ,UITableViewDelegate,UITableViewDataSource,CartProductAddOrRemove,UIAlertViewDelegate{

    let dbTable:UITableView = UITableView()
    var cart:CartModel!
    
    var isSubmitOrderAlertView:UIAlertView!
    
    //总金恩
    private lazy var lbZongJiPrice: UILabel = {
        let lbZongJiPrice = UILabel()
        lbZongJiPrice.text = "总金额:"
        lbZongJiPrice.font = UIFont.boldSystemFontOfSize(20)
        lbZongJiPrice.textColor =  AppProductPriceTextColor
        return lbZongJiPrice
    }()
    
    //总金额值
    private lazy var lbZongJiPriceValue: UILabel = {
        let lbZongJiPriceValue = UILabel()
        lbZongJiPriceValue.font = UIFont.boldSystemFontOfSize(24)
        lbZongJiPriceValue.textColor =  AppProductPriceValueColor
        return lbZongJiPriceValue
    }()
    
    //下单按钮
    private lazy var btnOrder: UIButton = {
        let btnOrder = UIButton()
        btnOrder.setTitle("下单", forState: UIControlState.Normal)
        btnOrder.setBackgroundImage(UIImage(named: "openorder_004"), forState:UIControlState.Normal)
        btnOrder.addTarget(self, action: #selector(CartView.btnOrderClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return btnOrder
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AppDetailsProductBgColor
        cart = CartTools.getCurrentCart()
    }
    
    func setBaseView() {
        let lineView1 = UIView()
        lineView1.backgroundColor = AppLineBgColor
        self.addSubview(lineView1)
        lineView1.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(40)
            make.height.equalTo(20)
            make.width.equalTo(2)
        }
        
        let lbPName:UILabel = UILabel()
        lbPName.textColor = AppLineBgColor
        lbPName.text = "已点菜单"
        self.addSubview(lbPName)
        lbPName.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(45)
            make.height.equalTo(20)
        }
        
        let lbOrderNo:UILabel = UILabel()
         lbOrderNo.textColor = AppLineBgColor
        lbOrderNo.text = "订单号\(cart.CartId)"
        self.addSubview(lbOrderNo)
        lbOrderNo.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(140)
            make.height.equalTo(20)

        }
        
        let lineView2 = UIView()
        lineView2.backgroundColor = AppLineBgColor
        self.addSubview(lineView2)
        lineView2.snp_makeConstraints { (make) in
            make.top.equalTo(70)
            make.left.equalTo(40)
            make.height.equalTo(1)
            make.width.equalTo(520)
        }
        
        let btnClose = UIButton()
        btnClose.addTarget(self, action: #selector(CartView.btnCloseClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnClose.setBackgroundImage(UIImage(named: "details_close"), forState:UIControlState.Normal)
        self.addSubview(btnClose)
        btnClose.snp_makeConstraints { (make) in
            make.top.equalTo(35)
            make.right.equalTo(-64)
            make.width.equalTo(23)
            make.height.equalTo(24)
        }
        
        self.addSubview(lbZongJiPrice)
        lbZongJiPrice.snp_makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.right.equalTo(-350)
        }
        
        self.addSubview(lbZongJiPriceValue)
        lbZongJiPriceValue.snp_makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.right.equalTo(-270)
        }
        
        self.addSubview(btnOrder)
        btnOrder.snp_makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.right.equalTo(-80)
            make.width.equalTo(76)
            make.height.equalTo(31)
        }
    }
    
    func setListView(){
        dbTable.dataSource = self
        dbTable.delegate = self
        dbTable.separatorStyle = UITableViewCellSeparatorStyle.None
        dbTable.backgroundColor = UIColor.clearColor()
        dbTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.addSubview(dbTable)
        dbTable.snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(0)
            make.bottom.equalTo(-50)
            make.right.equalTo(-50)
        }
    }
    
    
    
    func btnCloseClicked(sender:UIButton) {
        self.superview?.removeFromSuperview()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 130
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cart.List.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = CartViewCell(style: .Default, reuseIdentifier: "myCell")
        cell.objCartItemModel = cart.List[indexPath.row]
        cell.delgateCartProductAddOrRemove = self
        return cell
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        setBaseView()
        setListView()
        cart = CartTools.getCurrentCart()
        lbZongJiPriceValue.text = "￥\(cart.TotalMoney)"
        dbTable.reloadData()
    }
    
    func reloadTable() {
        cart = CartTools.getCurrentCart()
        lbZongJiPriceValue.text = "￥\(cart.TotalMoney)"
        dbTable.reloadData()
    }
    
    //指定购物车项增加一个
    func addOne(item:CartItemModel)
    {
        if(CartTools.checkCartIsExist())
        {
            let cart:CartModel =  CartTools.getCurrentCart()
            cart.addProduct(AddProduct: item.Item)
            CartTools.setCart(cart)
            reloadTable()
        }else //购物车不存在
        {
            ViewAlertTextCommon.ShowSimpleText("尚未开单，请先开单", view: self)
        }
    }
    
    //指定购物车项减少一个
    func removeOne(item:CartItemModel)
    {
        if(CartTools.checkCartIsExist())
        {
            let cart:CartModel =  CartTools.getCurrentCart()
            cart.removeProductOne(RemoveProduct: item.Item)
            CartTools.setCart(cart)
            reloadTable()
        }else{
            ViewAlertTextCommon.ShowSimpleText("尚未开单，请先开单", view: self)
        }
    }
    
    
    
    //指定购物车项整项移除
    func removeAll(item:CartItemModel)
    {
        if(CartTools.checkCartIsExist())
        {
            let cart:CartModel =  CartTools.getCurrentCart()
            cart.removeItem(RemoveProduct: item.Item)
            CartTools.setCart(cart)
            reloadTable()
        }else{
            ViewAlertTextCommon.ShowSimpleText("尚未开单，请先开单", view: self)
        }
    }
    
    
    //下单
    func btnOrderClicked(sender:UIButton)  {
        if(CartTools.getCurrentCart().List.count>0)
        {
            isSubmitOrderAlertView = UIAlertView()
            isSubmitOrderAlertView.delegate = self
            isSubmitOrderAlertView.tag = 1
            isSubmitOrderAlertView.message = "确认提交本订单?"
            isSubmitOrderAlertView.title = "提示"
            isSubmitOrderAlertView.addButtonWithTitle("是的")
            isSubmitOrderAlertView.addButtonWithTitle("不要")
            isSubmitOrderAlertView.show()
        }
        else{
            ViewAlertTextCommon.ShowSimpleText("购物车尚无任何东西，不能提交", view: self)
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(alertView.tag == 1)
        {
            if(buttonIndex == 0)//确认提交
            {
                //构建订单
                let jsonStr = CartTools.cartObj2Json()
                let parameters = [
                    "_json": jsonStr,
                    "op":"add"
                ]
                
                let url = AppServerURL+"ProcessingOrders"
                let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
                hud.label.text = "订单处理中"
                Alamofire.request(.GET, url,parameters: parameters).responseJSON { (response) in
                    switch response.result {
                    case.Success(let data):
                        let json = JSON(data)
                        if(json["ResultCode"] == "200")//登录成功
                        {
                            CartTools.removeCart()
                            self.superview?.removeFromSuperview()
                            ViewAlertTextCommon.ShowSimpleText("提交成功", view: self)
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
    }
    
    
   
}
