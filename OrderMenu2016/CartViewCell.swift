//
//  CartViewCell.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/8/18.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit

//购物车列表cell
class CartViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        addSubview(btnDelete)
        addSubview(productImageView)
        addSubview(lbCaiMingValue)
        addSubview(lbPrice)
        addSubview(lbPriceValue)
        addSubview(lbYiDian)
        addSubview(txtYiDian)
        addSubview(lbFen)
        addSubview(lbXiaoJiPrice)
        addSubview(lbXiaoJiPriceValue)
        addSubview(btnJian)
        addSubview(btnJia)
        addSubview(lineView1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //删除图片按钮
    private lazy var btnDelete:UIButton = {
        
        let btnDelete = UIButton()
        btnDelete.setBackgroundImage(UIImage(named: "cart_002"), forState: UIControlState.Normal)
        return btnDelete
    }()

    
    //商品图片
    private lazy var productImageView: UIImageView = {
        let productImageView = UIImageView()
        return productImageView
    }()
    
    //商品名字
    private lazy var lbCaiMingValue: UILabel = {
        let lbCaiMingValue = UILabel()
        lbCaiMingValue.textColor = AppProductPriceTextColor
        return lbCaiMingValue
    }()
    
    //商品价格标签
    private lazy var lbPrice: UILabel = {
        let lbPrice = UILabel()
        lbPrice.text = "单价:"
        lbPrice.font = UIFont.boldSystemFontOfSize(20)
        lbPrice.textColor =  AppProductPriceTextColor
        return lbPrice
    }()
    
    //菜品价格值
    private lazy var lbPriceValue: UILabel = {
        let lbPriceValue = UILabel()
        lbPriceValue.font = UIFont.boldSystemFontOfSize(24)
        lbPriceValue.textColor =  AppProductPriceValueColor
        return lbPriceValue
    }()
    
    //已点标签
    private lazy var lbYiDian: UILabel = {
        let lbYiDian = UILabel()
        lbYiDian.text = "已点"
        lbYiDian.font = UIFont.boldSystemFontOfSize(20)
        lbYiDian.textColor = AppLineBgColor
        return lbYiDian
    }()
    
    //已点文本框
    private lazy var txtYiDian: UITextField = {
        let txtYiDian = UITextField()
        txtYiDian.textColor = AppProductPriceTextColor
        txtYiDian.layer.cornerRadius = 5
        txtYiDian.font = UIFont.boldSystemFontOfSize(20)
        txtYiDian.textAlignment = NSTextAlignment.Center
        txtYiDian.layer.borderWidth = 1
        txtYiDian.layer.borderColor = AppLineBgColor.CGColor
        return txtYiDian
    }()
    
    //份
    private lazy var lbFen: UILabel = {
        let lbFen = UILabel()
        lbFen.text = "份"
        lbFen.font = UIFont.boldSystemFontOfSize(20)
        lbFen.textColor = AppLineBgColor
        return lbFen
    }()
    
    //小计
    private lazy var lbXiaoJiPrice: UILabel = {
        let lbXiaoJiPrice = UILabel()
        lbXiaoJiPrice.text = "小计:"
        lbXiaoJiPrice.font = UIFont.boldSystemFontOfSize(20)
        lbXiaoJiPrice.textColor =  AppProductPriceTextColor
        return lbXiaoJiPrice
    }()

    //小计金额￥
    private lazy var lbXiaoJiPriceValue: UILabel = {
        let lbXiaoJiPriceValue = UILabel()
        lbXiaoJiPriceValue.font = UIFont.boldSystemFontOfSize(24)
        lbXiaoJiPriceValue.textColor =  AppProductPriceValueColor
        return lbXiaoJiPriceValue
    }()
    
    //减 图片按钮
    private lazy var btnJian:UIButton = {
        let btnJian = UIButton()
        btnJian.setBackgroundImage(UIImage(named: "jian"), forState: UIControlState.Normal)
        return btnJian
    }()
    
    //加 图片按钮
    private lazy var btnJia:UIButton = {
        let btnJia = UIButton()
        btnJia.setBackgroundImage(UIImage(named: "jia"), forState: UIControlState.Normal)
        return btnJia
    }()
    
    //分割线
    private lazy var lineView1:UIView = {
      let lineView1 = UIView()
        lineView1.backgroundColor = AppLineBgColor
        return lineView1
    }()
    
    // MARK: 模型setter方法
    var objCartItemModel: CartItemModel! {
        didSet {
            productImageView.sd_setImageWithURL( NSURL(string: "\(AppServer)uploadFiles/\(objCartItemModel.Item.ImgName)"))
            lbCaiMingValue.text = objCartItemModel.Item.CName
            lbPriceValue.text = "￥\(objCartItemModel.Item.Price1)"
            txtYiDian.text = "\(objCartItemModel.Count)"
            lbXiaoJiPriceValue.text = "￥\(objCartItemModel.TotalPrice)"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        btnDelete.snp_makeConstraints { (make) in
            make.width.equalTo(30)
            make.left.equalTo(5)
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(26)
        }
        
        productImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(40)
            make.width.equalTo(162)
            make.height.equalTo(97)
        }
        
        lbCaiMingValue.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(220)
        }
        
        lbPrice.snp_makeConstraints { (make) in
            make.top.equalTo(45)
            make.left.equalTo(220)
        }

        lbPriceValue.snp_makeConstraints { (make) in
            make.top.equalTo(45)
            make.left.equalTo(270)
        }
        
        lbYiDian.snp_makeConstraints { (make) in
            make.left.equalTo(220)
            make.top.equalTo(90)
        }
        
        txtYiDian.snp_makeConstraints { (make) in
            make.left.equalTo(270)
            make.top.equalTo(90)
            make.width.equalTo(40)
        }
        
        lbFen.snp_makeConstraints { (make) in
            make.left.equalTo(320)
            make.top.equalTo(90)
        }
        
        lbXiaoJiPrice.snp_makeConstraints { (make) in
            make.top.equalTo(90)
            make.right.equalTo(-120)
        }
        
        lbXiaoJiPriceValue.snp_makeConstraints { (make) in
            make.top.equalTo(90)
            make.right.equalTo(-50)
        }

        btnJian.snp_makeConstraints { (make) in
            make.right.equalTo(-90)
            make.top.equalTo(20)
            make.width.equalTo(54)
            make.height.equalTo(34)
        }
        
        btnJia.snp_makeConstraints { (make) in
            make.right.equalTo(-30)
            make.top.equalTo(20)
            make.width.equalTo(54)
            make.height.equalTo(34)
        }
        
        lineView1.snp_makeConstraints { (make) in
            make.left.equalTo(40)
            make.height.equalTo(1)
            make.bottom.equalTo(-1)
            make.right.equalTo(0)
        }
    }
}
