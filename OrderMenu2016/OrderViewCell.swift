//
//  OrderViewCell.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/8/18.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import SnapKit

//订单列表单元cell
class OrderViewCell: UITableViewCell {

    //订单商品图片
    private lazy var pImage: UIImageView = {
       
       let  pImage = UIImageView(image: UIImage(named: "cart_004"))
        return pImage
    }()
    
    //单号标签
    private lazy var lbDanhao:UILabel = {
         let lbDanhao = UILabel()
        lbDanhao.text = "单号:"
        lbDanhao.textColor = AppProductPriceTextColor
        return lbDanhao
    }()
    
 
    //单号值
    private lazy var lbDanhaoValue:UILabel = {
        let lbDanhaoValue = UILabel()
        lbDanhaoValue.textColor = AppProductPriceTextColor
        return lbDanhaoValue
    }()
    
    //台位
    private lazy var lbZuoWei:UILabel = {
        let lbZuoWei = UILabel()
        lbZuoWei.text = "座位:"
        lbZuoWei.textColor = AppProductPriceTextColor
        return lbZuoWei
    }()
    
    //台位值
    private lazy var lbZuoWeiValue:UILabel = {
        let lbZuoWeiValue = UILabel()
        lbZuoWeiValue.text = "座位:"
        lbZuoWeiValue.textColor = AppProductPriceTextColor
        return lbZuoWeiValue
    }()
    
    //时间标签
    private lazy var lbShiJian:UILabel = {
        let lbShiJian = UILabel()
        lbShiJian.text = "时间:"
        lbShiJian.textColor = AppProductPriceTextColor
        return lbShiJian
    }()
    
    //时间
    private lazy var lbShiJianValue:UILabel = {
        let lbShiJianValue = UILabel()
        lbShiJianValue.textColor = AppProductPriceTextColor
        return lbShiJianValue
    }()
    
    //员工标签
    private lazy var lbYuanGong:UILabel = {
        let lbYuanGong = UILabel()
        lbYuanGong.text = "服务员:"
        lbYuanGong.textColor = AppProductPriceTextColor
        return lbYuanGong
    }()
    
    //员工
    private lazy var lbYuanGongValue:UILabel = {
        let lbYuanGongValue = UILabel()
        lbYuanGongValue.textColor = AppProductPriceTextColor
        return lbYuanGongValue
    }()
    
    //描述
    private lazy var lbDesc:UILabel = {
        let lbDesc = UILabel()
        lbDesc.textColor = AppProductPriceTextColor
        return lbDesc
    }()
    

    
    //总价格
    private lazy var lbMoney:UILabel = {
        let lbMoney = UILabel()
        lbMoney.textColor = AppProductPriceValueColor
        lbMoney.text = "￥1234.56"
        return lbMoney
    }()
    
    private lazy var btnAdd:UIButton = {
        let btnAdd:UIButton = UIButton()
        btnAdd.setBackgroundImage(UIImage(named: "cart_001"), forState: UIControlState.Normal)
         return btnAdd
    }()
    
    //分割线
    private lazy var lineView1:UIView = {
        let lineView1 = UIView()
        lineView1.backgroundColor = AppLineBgColor
        return lineView1
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        addSubview(pImage)
        addSubview(lbDanhao)
        addSubview(lbDanhaoValue)
        addSubview(lbZuoWei)
        addSubview(lbZuoWeiValue)
        addSubview(lbShiJian)
        addSubview(lbShiJianValue)
        addSubview(lbYuanGong)
        addSubview(lbYuanGongValue)
        addSubview(lbDesc)
        addSubview(lbMoney)
        addSubview(btnAdd)
        addSubview(lineView1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 模型setter方法
    var order: OrderViewModel! {
        didSet {
           
            lbDanhaoValue.text = order.orderNo
            lbZuoWeiValue.text = order.Seat
            lbShiJianValue.text = order.CreateTime
            lbYuanGongValue.text = order.MemberName
            lbDesc.text = order.getDesc()
            lbMoney.text = "￥\(order.getTotal())"
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pImage.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(40)
            make.width.equalTo(162)
            make.height.equalTo(97)
        }
        
        lbDanhao.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(220)
        }

        lbDanhaoValue.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(265)
        }
        
        lbZuoWei.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(450)
        }
        
        lbZuoWeiValue.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(495)
        }
        
        lbShiJian.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(220)
        }
        
        lbShiJianValue.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(265)
        }
        
        lbYuanGong.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(450)
        }
        
        lbYuanGongValue.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(510)
        }

        lbDesc.snp_makeConstraints { (make) in
            make.top.equalTo(70)
            make.left.equalTo(220)
            make.width.equalTo(350)
        }
        
        lbMoney.snp_makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(220)
            make.width.equalTo(350)
        }
        
        btnAdd.snp_makeConstraints { (make) in
            make.top.equalTo(93)
            make.right.equalTo(-20)
            make.width.equalTo(86)
            make.height.equalTo(36)
        }
        
        lineView1.snp_makeConstraints { (make) in
            make.left.equalTo(40)
            make.height.equalTo(1)
            make.bottom.equalTo(-1)
            make.right.equalTo(0)
        }
        
    }
    
}
