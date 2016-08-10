//
//  OpenOrderView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/23.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//选人，选桌子，开单
class OpenOrderView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
        var myListView:UICollectionView!
    
        var seatAr:[SeatModel] = []
        var empAr:[EmpModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AppDetailsProductBgColor
        
        //加载台位和服务员信息
        let url = AppServerURL+"GetSeatANDMember"
        let parameters = [
            "_orgid": LoginUserTools.getCurrentOrgId()
        ]
        let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
        hud.label.text = "正在获取台位和服务员信息..."
        Alamofire.request(.GET, url,parameters: parameters).responseJSON { (response) in
            switch response.result {
            case.Success(let data):
                let json = JSON(data)
                if(json["ResultCode"] == "200")//请求成功
                {
                    self.seatAr.removeAll()
                    self.empAr.removeAll()
                    for obj in json["Data1"]["Seats"]
                    {
                        let vm:SeatModel = SeatModel()
                         vm.OID = "\(obj.1["OID"])"
                         vm.ParentID = "\(obj.1["ParentID"])"
                         vm.SeatNo = "\(obj.1["SeatNo"])"
                         vm.SaatCategory = "\(obj.1["SaatCategory"])"
                         vm.PersonNum = "\(obj.1["PersonNum"])"
                         vm.OrgID = "\(obj.1["OrgID"])"
                         vm.Desc = "\(obj.1["Desc"])"
                         vm.Status = "\(obj.1["Status"])"
                         self.seatAr.append(vm)
                    }
                    
                    for objEmp in json["Data1"]["Members"]
                    {
                        let em:EmpModel = EmpModel()
                         em.OID = "\(objEmp.1["Status"])"
                         em.Cname = "\(objEmp.1["Cname"])"
                         em.Gender = "\(objEmp.1["Gender"])"
                         em.Introduction = "\(objEmp.1["Introduction"])"
                         em.OrgID = "\(objEmp.1["OrgID"])"
                         em.DeletionStateCode = "\(objEmp.1["DeletionStateCode"])"
                         em.Enabled = "\(objEmp.1["Enabled"])"
                         em.SortCode = "\(objEmp.1["SortCode"])"
                         em.Description = "\(objEmp.1["Description"])"
                         em.CreateOn = "\(objEmp.1["CreateOn"])"
                         em.CreateUserId = "\(objEmp.1["CreateUserId"])"
                         em.CreateBy = "\(objEmp.1["CreateBy"])"
                         em.ModifiedOn = "\(objEmp.1["ModifiedOn"])"
                         em.ModifiedUserId = "\(objEmp.1["ModifiedUserId"])"
                         em.ModifiedBy = "\(objEmp.1["ModifiedBy"])"
                         self.empAr.append(em)
                    }
                    self.setBaseView()
                    self.setListView()

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
        }//加载台位和服务员信息结束
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setListView() {
        let layout = UICollectionViewFlowLayout()
        myListView = UICollectionView(frame: (frame: CGRectMake(0, 110, self.bounds.width, self.bounds.height-110)),collectionViewLayout: layout)
        myListView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "mycell")
        myListView.backgroundColor = UIColor.clearColor()
        myListView.dataSource = self
        myListView.delegate = self
        self.addSubview(myListView)

    }
    
    func setBaseView() {
        let lineView1 = UIView()
        lineView1.backgroundColor = AppLineBgColor
        self.addSubview(lineView1)
        lineView1.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(30)
            make.height.equalTo(20)
            make.width.equalTo(2)
        }
        
        let lbPName:UILabel = UILabel()
        lbPName.textColor = AppLineBgColor
        lbPName.text = "人数/座位/服务员"
        self.addSubview(lbPName)
        lbPName.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(35)
            make.height.equalTo(20)
        }
        
        let lbOrderNo:UILabel = UILabel()
        lbOrderNo.textColor = AppLineBgColor
        lbOrderNo.text = ""
        self.addSubview(lbOrderNo)
        lbOrderNo.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(220)
            make.height.equalTo(20)
        }
        
        //加载新订单号
        let url = AppServerURL+"GetOrderNo"
        let parameters = [
            "_orgid": LoginUserTools.getCurrentOrgId()
        ]
        let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
        hud.label.text = "正在获取订单号..."
        Alamofire.request(.GET, url,parameters: parameters).responseJSON { (response) in
            switch response.result {
            case.Success(let data):
                let json = JSON(data)
                if(json["ResultCode"] == "200")//请求成功
                {
                   lbOrderNo.text = "订单号:\(json["strNo"])"
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
        }//加载新订单号结束

        
        let lineView2 = UIView()
        lineView2.backgroundColor = AppLineBgColor
        self.addSubview(lineView2)
        lineView2.snp_makeConstraints { (make) in
            make.top.equalTo(70)
            make.left.equalTo(30)
            make.height.equalTo(1)
            make.width.equalTo(750)
        }
        
        let btnBegin = UIButton()
        btnBegin.setBackgroundImage(UIImage(named: "openOrder_003"), forState:UIControlState.Normal)
        self.addSubview(btnBegin)
        btnBegin.snp_makeConstraints { (make) in
            make.top.equalTo(35)
            make.right.equalTo(-150)
            make.width.equalTo(76)
            make.height.equalTo(31)
        }

        
        
        let btnClose = UIButton()
        btnClose.addTarget(self, action: #selector(OpenOrderView.btnCloseClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnClose.setBackgroundImage(UIImage(named: "details_close"), forState:UIControlState.Normal)
        self.addSubview(btnClose)
        btnClose.snp_makeConstraints { (make) in
            make.top.equalTo(35)
            make.right.equalTo(-64)
            make.width.equalTo(23)
            make.height.equalTo(24)
        }
        
        let lbRenShu:UILabel = UILabel()
        lbRenShu.text = "人数:"
        lbRenShu.font = UIFont.boldSystemFontOfSize(20)
        lbRenShu.textColor = AppLineBgColor
        self.addSubview(lbRenShu)
        lbRenShu.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(80)
        }
        
        let txtRenShu:UITextField = UITextField()
        txtRenShu.text = "5"
        txtRenShu.textColor = AppLineBgColor
        txtRenShu.layer.cornerRadius = 5
        txtRenShu.keyboardType = UIKeyboardType.PhonePad
        txtRenShu.font = UIFont.boldSystemFontOfSize(20)
        txtRenShu.textAlignment = NSTextAlignment.Center
        txtRenShu.layer.borderWidth = 1
        txtRenShu.layer.borderColor = AppLineBgColor.CGColor
        self.addSubview(txtRenShu)
        txtRenShu.snp_makeConstraints { (make) in
            make.left.equalTo(80)
            make.top.equalTo(80)
            make.width.equalTo(60)
        }
        
        let lbGe:UILabel = UILabel()
        lbGe.text = "个"
        lbGe.font = UIFont.boldSystemFontOfSize(20)
        lbGe.textColor = AppLineBgColor
        self.addSubview(lbGe)
        lbGe.snp_makeConstraints { (make) in
            make.left.equalTo(150)
            make.top.equalTo(80)
        }

        let lbZuoWei:UILabel = UILabel()
        lbZuoWei.text = "座位:"
        lbZuoWei.font = UIFont.boldSystemFontOfSize(20)
        lbZuoWei.textColor = AppLineBgColor
        self.addSubview(lbZuoWei)
        lbZuoWei.snp_makeConstraints { (make) in
            make.left.equalTo(300)
            make.top.equalTo(80)
        }
        
        let txtZuoWei:UITextField = UITextField()
        txtZuoWei.text = "501"
        txtZuoWei.textColor = AppLineBgColor
        txtZuoWei.layer.cornerRadius = 5
        txtZuoWei.font = UIFont.boldSystemFontOfSize(20)
        txtZuoWei.textAlignment = NSTextAlignment.Center
        txtZuoWei.layer.borderWidth = 1
        txtZuoWei.layer.borderColor = AppLineBgColor.CGColor
        self.addSubview(txtZuoWei)
        txtZuoWei.snp_makeConstraints { (make) in
            make.left.equalTo(350)
            make.top.equalTo(80)
            make.width.equalTo(80)
        }
        
        let lbFuWuYuan:UILabel = UILabel()
        lbFuWuYuan.text = "服务员:"
        lbFuWuYuan.font = UIFont.boldSystemFontOfSize(20)
        lbFuWuYuan.textColor = AppLineBgColor
        self.addSubview(lbFuWuYuan)
        lbFuWuYuan.snp_makeConstraints { (make) in
            make.right.equalTo(-200)
            make.top.equalTo(80)
        }
        
        let txtFuWuYuan:UITextField = UITextField()
        txtFuWuYuan.text = "店小二"
        txtFuWuYuan.textColor = AppLineBgColor
        txtFuWuYuan.layer.cornerRadius = 5
        txtFuWuYuan.font = UIFont.boldSystemFontOfSize(20)
        txtFuWuYuan.textAlignment = NSTextAlignment.Center
        txtFuWuYuan.layer.borderWidth = 1
        txtFuWuYuan.layer.borderColor = AppLineBgColor.CGColor
        self.addSubview(txtFuWuYuan)
        txtFuWuYuan.snp_makeConstraints { (make) in
            make.right.equalTo(-100)
            make.top.equalTo(80)
            make.width.equalTo(80)
        }
        
        let bgView = UIImageView(image: UIImage(named: "OpenOrder_bg"))
        self.addSubview(bgView)
        bgView.snp_makeConstraints { (make) in
            make.top.equalTo(90)
            make.left.equalTo(30)
            make.width.equalTo(652)
            make.height.equalTo(663)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.seatAr.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("mycell", forIndexPath: indexPath)
        cell.contentView.backgroundColor = UIColor.clearColor()
        
        let productImageView:UIImageView = UIImageView(image: UIImage(named: "openorder_007"))
        productImageView.layer.borderWidth = 1
        productImageView.layer.borderColor = AppLineBgColor.CGColor
        cell.contentView.addSubview(productImageView)
        productImageView.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        let tableNoView = UIImageView(image: UIImage(named: "openorder_004"))
        cell.contentView.addSubview(tableNoView)
        tableNoView.snp_makeConstraints { (make) in
            make.top.equalTo(2)
            make.left.equalTo(2)
            make.width.equalTo(76)
            make.height.equalTo(31)
        }
        
        let lbTableNo = UILabel()
        lbTableNo.textColor = UIColor.whiteColor()
        lbTableNo.text = self.seatAr[indexPath.row].SeatNo
        tableNoView.addSubview(lbTableNo)
        lbTableNo.snp_makeConstraints { (make) in
            make.center.equalTo(tableNoView)
        }
        
        
        let btnSelectSeat = UIButton()
        btnSelectSeat.setBackgroundImage(UIImage(named: "openorder_004"), forState: UIControlState.Normal)
        btnSelectSeat.setTitle("选座", forState: UIControlState.Normal)
        cell.contentView.addSubview(btnSelectSeat)
        btnSelectSeat.snp_makeConstraints { (make) in
            make.right.equalTo(-2)
            make.bottom.equalTo(-2)
            make.width.equalTo(76)
            make.height.equalTo(31)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(250, 181)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }

    
    func btnCloseClicked(sender:UIButton) {
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
