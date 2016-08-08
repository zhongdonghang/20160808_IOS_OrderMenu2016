//
//  OrderListView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/23.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit

class OrderListView: UIView ,UITableViewDelegate,UITableViewDataSource{
    
    let dbTable:UITableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AppDetailsProductBgColor
        setBaseView()
        setListView()
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
        dbTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.addSubview(dbTable)
        dbTable.snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(0)
            make.bottom.equalTo(-50)
            make.right.equalTo(-50)
        }

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
        
        
        let pImage:UIImageView = UIImageView(image: UIImage(named: "cart_004"))
        cell.contentView.addSubview(pImage)
        pImage.snp_makeConstraints { (make) in
            make.centerY.equalTo(cell.contentView)
            make.left.equalTo(40)
            make.width.equalTo(162)
            make.height.equalTo(97)
        }
        
        let lbDanhao = UILabel()
        lbDanhao.text = "单号:"
        lbDanhao.textColor = AppProductPriceTextColor
        cell.contentView.addSubview(lbDanhao)
        lbDanhao.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(220)
        }
        
        let lbDanhaoValue = UILabel()
        lbDanhaoValue.text = "20160624001"
        lbDanhaoValue.textColor = AppProductPriceTextColor
        cell.contentView.addSubview(lbDanhaoValue)
        lbDanhaoValue.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(265)
        }
        
        let lbZuoWei = UILabel()
        lbZuoWei.text = "座位:"
        lbZuoWei.textColor = AppProductPriceTextColor
        cell.contentView.addSubview(lbZuoWei)
        lbZuoWei.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(400)
        }
        
        let lbZuoWeiValue = UILabel()
        lbZuoWeiValue.text = "A0001"
        lbZuoWeiValue.textColor = AppProductPriceTextColor
        cell.contentView.addSubview(lbZuoWeiValue)
        lbZuoWeiValue.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(445)
        }
        
        let lbShiJian = UILabel()
        lbShiJian.text = "时间:"
        lbShiJian.textColor = AppProductPriceTextColor
        cell.contentView.addSubview(lbShiJian)
        lbShiJian.snp_makeConstraints { (make) in
            make.top.equalTo(50)
            make.left.equalTo(220)
        }
        
        let lbShiJianValue = UILabel()
        lbShiJianValue.text = "07-24 20:06"
        lbShiJianValue.textColor = AppProductPriceTextColor
        cell.contentView.addSubview(lbShiJianValue)
        lbShiJianValue.snp_makeConstraints { (make) in
            make.top.equalTo(50)
            make.left.equalTo(265)
        }
        
        let lbYuanGong = UILabel()
        lbYuanGong.text = "员工:"
        lbYuanGong.textColor = AppProductPriceTextColor
        cell.contentView.addSubview(lbYuanGong)
        lbYuanGong.snp_makeConstraints { (make) in
            make.top.equalTo(50)
            make.left.equalTo(400)
        }
        
        let lbYuanGongValue = UILabel()
        lbYuanGongValue.text = "克林斯曼"
        lbYuanGongValue.textColor = AppProductPriceTextColor
        cell.contentView.addSubview(lbYuanGongValue)
        lbYuanGongValue.snp_makeConstraints { (make) in
            make.top.equalTo(50)
            make.left.equalTo(445)
        }
        
        let lbDesc = UILabel()
        lbDesc.text = "描述:"
        lbDesc.textColor = AppProductPriceTextColor
        cell.contentView.addSubview(lbDesc)
        lbDesc.snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(220)
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
