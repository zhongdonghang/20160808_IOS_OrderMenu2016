//
//  OrderListView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/23.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OrderListView: UIView ,UITableViewDelegate,UITableViewDataSource,IOrderAdd,UIAlertViewDelegate{
    
    let dbTable:UITableView = UITableView()
    var list:[OrderViewModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = AppDetailsProductBgColor
        setBaseView()
        setListView()
        loadOrderList()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBaseView()
    {
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
        lbPName.text = "订单列表"
        self.addSubview(lbPName)
        lbPName.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(45)
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
        btnClose.addTarget(self, action: #selector(OrderListView.btnCloseClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnClose.setBackgroundImage(UIImage(named: "details_close"), forState:UIControlState.Normal)
        self.addSubview(btnClose)
        btnClose.snp_makeConstraints { (make) in
            make.top.equalTo(35)
            make.right.equalTo(-64)
            make.width.equalTo(23)
            make.height.equalTo(24)
        }
    }
    
    func  setListView(){
        dbTable.dataSource = self
        dbTable.delegate = self
        
        dbTable.separatorStyle = UITableViewCellSeparatorStyle.None
        dbTable.backgroundColor = UIColor.clearColor()
        dbTable.registerClass(OrderViewCell.self, forCellReuseIdentifier: "myCell")
        self.addSubview(dbTable)
        dbTable.snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(0)
            make.bottom.equalTo(-50)
            make.right.equalTo(-50)
        }
        
    }
    
    func loadOrderList()
    {
        let url = AppServerURL+"GetSimpleOrderList"
        print(url)
        let parameters = [
            "_pageIndex":"0",
            "_pageSize":"9999",
            "_orgid": LoginUserTools.getCurrentOrgId()
        ]
        let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
        hud.label.text = "loading..."
        Alamofire.request(.GET, url,parameters: parameters).responseJSON { (response) in
            switch response.result {
            case.Success(let data):
                let json = JSON(data)
                if(json["ResultCode"] == "200")//请求成功
                {
                    self.list.removeAll()
                    for obj in json["Page"]["Data"]
                    {
                        let objOrder = OrderViewModel()
                        objOrder.MemberName = "\(obj.1["MemberName"])"
                        objOrder.CreateTime = "\(obj.1["CreateTime"])"
                        objOrder.orderNo = "\(obj.1["orderNo"])"
                        objOrder.Dec = "\(obj.1["Dec"])"
                        objOrder.Seat = "\(obj.1["Seat"])"
                        objOrder.PeopleNum = "\(obj.1["PeopleNum"])"
                        
                        for objItem in obj.1["orderInfo"]
                        {
                            let objOrderItemViewModel:OrderItemViewModel=OrderItemViewModel()
                            objOrderItemViewModel.MemberName = "\(objItem.1["MemberName"])"
                            print(objOrderItemViewModel.MemberName )
                            objOrderItemViewModel.CreateOn = "\(objItem.1["CreateOn"])"
                            objOrderItemViewModel.OrderNo = "\(objItem.1["OrderNo"])"
                            objOrderItemViewModel.ProductId = "\(objItem.1["ProductId"])"
                            objOrderItemViewModel.PNum = "\(objItem.1["PNum"])"
                            objOrderItemViewModel.Price1 = "\(objItem.1["Price1"])"
                            objOrderItemViewModel.ProductCname = "\(objItem.1["ProductCname"])"
                            objOrderItemViewModel.OID = "\(objItem.1["OID"])"
                            objOrderItemViewModel.Price2 = "\(objItem.1["Price2"])"
                            objOrderItemViewModel.ModifiedOn = "\(objItem.1["ModifiedOn"])"
                            objOrder.Items.append(objOrderItemViewModel)
                        }
                        self.list.append(objOrder)
                    }
                    self.dbTable.reloadData()
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 130
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = OrderViewCell(style: .Default, reuseIdentifier: "myCell")
        cell.order = list[indexPath.row]
        cell.delgateIOrderAdd = self
        return cell
    }

    var isAddAlertView:UIAlertView!
    var currentAddOrder:OrderViewModel!
    
    func OrderAdd(order:OrderViewModel)
    {
        currentAddOrder = order
         if(CartTools.checkCartIsExist())
         {
            isAddAlertView = UIAlertView()
            isAddAlertView.delegate = self
            isAddAlertView.tag = 1
            isAddAlertView.message = "当前尚有进行中的购物车，是否要放弃？"
            isAddAlertView.title = "提示"
            isAddAlertView.addButtonWithTitle("是的")
            isAddAlertView.addButtonWithTitle("不要")
            isAddAlertView.show()
         }else
         {
            CartTools.removeCart()
            let cart:CartModel = CartModel(OrderId: currentAddOrder.orderNo, SeatNo: currentAddOrder.Seat, PersonNum: 0, EmpNo: "追加")
            CartTools.setCart(cart)
            self.superview?.removeFromSuperview()
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(alertView.tag==1)
        {
            if(buttonIndex == 0)//加菜
            {
                CartTools.removeCart()
                let cart:CartModel = CartModel(OrderId: currentAddOrder.orderNo, SeatNo: currentAddOrder.Seat, PersonNum: 0, EmpNo: "追加")
                CartTools.setCart(cart)
                 self.superview?.removeFromSuperview()
            }
        }
    }
    
    func btnCloseClicked(sender:UIButton)  {
        self.superview?.removeFromSuperview()
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
