//
//  CartView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/23.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit

class CartView: UIView ,UITableViewDelegate,UITableViewDataSource{

    let dbTable:UITableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AppDetailsProductBgColor
        setBaseView()
        setListView()
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
        
        let lineView2 = UIView()
        lineView2.backgroundColor = AppLineBgColor
        self.addSubview(lineView2)
        lineView2.snp_makeConstraints { (make) in
            make.top.equalTo(70)
            make.left.equalTo(40)
            make.height.equalTo(1)
            make.width.equalTo(520)
        }
        
        let btnBegin = UIButton()
        btnBegin.setBackgroundImage(UIImage(named: "cart_001"), forState:UIControlState.Normal)
        self.addSubview(btnBegin)
        btnBegin.snp_makeConstraints { (make) in
            make.top.equalTo(35)
            make.right.equalTo(-100)
            make.width.equalTo(76)
            make.height.equalTo(31)
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
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        
        let btnDelete:UIButton = UIButton()
        btnDelete.setBackgroundImage(UIImage(named: "cart_002"), forState: UIControlState.Normal)
        cell.contentView.addSubview(btnDelete)
        btnDelete.snp_makeConstraints { (make) in
            make.width.equalTo(30)
            make.left.equalTo(5)
            make.centerY.equalTo(cell.contentView)
           make.height.equalTo(26)
        }
        
        let pImage:UIImageView = UIImageView(image: UIImage(named: "cart_004"))
         cell.contentView.addSubview(pImage)
        pImage.snp_makeConstraints { (make) in
             make.centerY.equalTo(cell.contentView)
            make.left.equalTo(40)
            make.width.equalTo(162)
            make.height.equalTo(97)
        }
        
        let lbCaiMingValue = UILabel()
        lbCaiMingValue.text = "蚂蚁上树"
        lbCaiMingValue.textColor = AppProductPriceTextColor
        cell.contentView.addSubview(lbCaiMingValue)
        lbCaiMingValue.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(220)
        }
        
        let lbPrice = UILabel()
        lbPrice.text = "价格:"
        lbPrice.font = UIFont.boldSystemFontOfSize(20)
        lbPrice.textColor =  AppProductPriceTextColor
        cell.contentView.addSubview(lbPrice)
        lbPrice.snp_makeConstraints { (make) in
            make.top.equalTo(45)
            make.left.equalTo(220)
        }
        
        let lbPriceValue = UILabel()
        lbPriceValue.text = "￥588元/份"
        lbPriceValue.font = UIFont.boldSystemFontOfSize(24)
        lbPriceValue.textColor =  AppProductPriceValueColor
        cell.contentView.addSubview(lbPriceValue)
        lbPriceValue.snp_makeConstraints { (make) in
            make.top.equalTo(45)
            make.left.equalTo(270)
        }
        
        let lbYiDian:UILabel = UILabel()
        lbYiDian.text = "已点"
        lbYiDian.font = UIFont.boldSystemFontOfSize(20)
        lbYiDian.textColor = AppLineBgColor
        cell.contentView.addSubview(lbYiDian)
        lbYiDian.snp_makeConstraints { (make) in
            make.left.equalTo(220)
            make.top.equalTo(90)
        }
        
        let txtYiDian:UITextField = UITextField()
        txtYiDian.text = "1"
        txtYiDian.textColor = AppProductPriceTextColor
        txtYiDian.layer.cornerRadius = 5
        txtYiDian.font = UIFont.boldSystemFontOfSize(20)
        txtYiDian.textAlignment = NSTextAlignment.Center
        txtYiDian.layer.borderWidth = 1
        txtYiDian.layer.borderColor = AppLineBgColor.CGColor
        cell.contentView.addSubview(txtYiDian)
        txtYiDian.snp_makeConstraints { (make) in
            make.left.equalTo(270)
            make.top.equalTo(90)
            make.width.equalTo(40)
        }
        
        let lbFen:UILabel = UILabel()
        lbFen.text = "份"
        lbFen.font = UIFont.boldSystemFontOfSize(20)
        lbFen.textColor = AppLineBgColor
        cell.contentView.addSubview(lbFen)
        lbFen.snp_makeConstraints { (make) in
            make.left.equalTo(320)
            make.top.equalTo(90)
        }
        
        
        let lbXiaoJiPrice = UILabel()
        lbXiaoJiPrice.text = "小计:"
        lbXiaoJiPrice.font = UIFont.boldSystemFontOfSize(20)
        lbXiaoJiPrice.textColor =  AppProductPriceTextColor
        cell.contentView.addSubview(lbXiaoJiPrice)
        lbXiaoJiPrice.snp_makeConstraints { (make) in
            make.top.equalTo(90)
            make.right.equalTo(-120)
        }
        
        let lbXiaoJiPriceValue = UILabel()
        lbXiaoJiPriceValue.text = "￥588"
        lbXiaoJiPriceValue.font = UIFont.boldSystemFontOfSize(24)
        lbXiaoJiPriceValue.textColor =  AppProductPriceValueColor
        cell.contentView.addSubview(lbXiaoJiPriceValue)
        lbXiaoJiPriceValue.snp_makeConstraints { (make) in
            make.top.equalTo(90)
            make.right.equalTo(-50)
        }

        let btnJian:UIButton = UIButton()
        btnJian.setBackgroundImage(UIImage(named: "jian"), forState: UIControlState.Normal)
        cell.contentView.addSubview(btnJian)
        btnJian.snp_makeConstraints { (make) in
            make.right.equalTo(-90)
            make.top.equalTo(20)
            make.width.equalTo(54)
            make.height.equalTo(34)
        }
        
        let btnJia:UIButton = UIButton()
        btnJia.setBackgroundImage(UIImage(named: "jia"), forState: UIControlState.Normal)
        cell.contentView.addSubview(btnJia)
        btnJia.snp_makeConstraints { (make) in
            make.right.equalTo(-30)
            make.top.equalTo(20)
            make.width.equalTo(54)
            make.height.equalTo(34)
        }
        
        let lineView1 = UIView()
        lineView1.backgroundColor = AppLineBgColor
        cell.contentView.addSubview(lineView1)
        lineView1.snp_makeConstraints { (make) in

            make.left.equalTo(40)
            make.height.equalTo(1)
            make.bottom.equalTo(-1)
            make.right.equalTo(0)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {

    }

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}