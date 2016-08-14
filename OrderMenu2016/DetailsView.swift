//
//  DetailsView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/22.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit
import SnapKit

class DetailsView: UIView {

    var currentProduct:ProductSimpleViewModel!
    
    let txtYiDian:UITextField = UITextField()
    
    init(frame: CGRect,product:ProductSimpleViewModel)
    {
        super.init(frame: frame)
        currentProduct = product
        self.backgroundColor = AppDetailsProductBgColor
        setBaseView()
        reloadInputViews()
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        lbPName.text = currentProduct.CName
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
            make.top.equalTo(65)
            make.left.equalTo(40)
            make.height.equalTo(1)
            make.width.equalTo(510)
        }
        
        let btnClose = UIButton()
        btnClose.addTarget(self, action: #selector(DetailsView.btnCloseClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnClose.setBackgroundImage(UIImage(named: "details_close"), forState:UIControlState.Normal)
        self.addSubview(btnClose)
        btnClose.snp_makeConstraints { (make) in
            make.top.equalTo(35)
            make.right.equalTo(-64)
            make.width.equalTo(23)
            make.height.equalTo(24)
        }

        let productImage:UIImageView = UIImageView()
        productImage.sd_setImageWithURL(NSURL(string: "http://1.nnbetter.com:8029/uploadFiles/\(currentProduct.ImgName)"))
        productImage.layer.borderWidth = 2
        productImage.layer.borderColor = AppLineBgColor.CGColor
        self.addSubview(productImage)
        productImage.snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(40)
            make.width.equalTo(252)
            make.height.equalTo(252)
        }
        
        let lbCaiMing = UILabel()
        lbCaiMing.text = "菜名:"
        lbCaiMing.textColor = AppProductPriceTextColor
        self.addSubview(lbCaiMing)
        lbCaiMing.snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(300)
        }
        
        let lbCaiMingValue = UILabel()
        lbCaiMingValue.text = currentProduct.CName
        lbCaiMingValue.textColor = AppProductPriceTextColor
        self.addSubview(lbCaiMingValue)
        lbCaiMingValue.snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(360)
        }
        
        let lbJianJie = UILabel()
        lbJianJie.text = "简介:"
        lbJianJie.textColor = AppProductPriceTextColor
        self.addSubview(lbJianJie)
        lbJianJie.snp_makeConstraints { (make) in
            make.top.equalTo(110)
            make.left.equalTo(300)
        }
        
        let lbJianJieValue = UILabel()
        lbJianJieValue.numberOfLines = 0
        lbJianJieValue.text = currentProduct.PContent
        lbJianJieValue.textColor = AppProductPriceTextColor
        self.addSubview(lbJianJieValue)
        lbJianJieValue.snp_makeConstraints { (make) in
            make.top.equalTo(140)
            make.left.equalTo(300)
            make.width.equalTo(240)
        }
        
        let lineView3 = UIView()
        lineView3.backgroundColor = AppLineBgColor
        self.addSubview(lineView3)
        lineView3.snp_makeConstraints { (make) in
            make.top.equalTo(348)
            make.left.equalTo(40)
            make.height.equalTo(1)
            make.width.equalTo(510)
        }
        
        let lbPrice = UILabel()
        lbPrice.text = "价格:"
        lbPrice.font = UIFont.boldSystemFontOfSize(20)
        lbPrice.textColor =  AppProductPriceTextColor
        self.addSubview(lbPrice)
        lbPrice.snp_makeConstraints { (make) in
            make.top.equalTo(355)
            make.left.equalTo(40)
        }
        
        let lbPriceValue = UILabel()
        lbPriceValue.text = "￥\(currentProduct.Price1)元/份"
        lbPriceValue.font = UIFont.boldSystemFontOfSize(24)
        lbPriceValue.textColor =  AppProductPriceValueColor
        self.addSubview(lbPriceValue)
        lbPriceValue.snp_makeConstraints { (make) in
            make.top.equalTo(355)
            make.left.equalTo(100)
        }
        
        
        let lbYiDian:UILabel = UILabel()
        lbYiDian.text = "已点"
        lbYiDian.font = UIFont.boldSystemFontOfSize(20)
        lbYiDian.textColor = AppLineBgColor
        self.addSubview(lbYiDian)
        lbYiDian.snp_makeConstraints { (make) in
            make.left.equalTo(300)
            make.top.equalTo(360)
        }
        
       
 
        
        let lbFen:UILabel = UILabel()
        lbFen.text = "份"
        lbFen.font = UIFont.boldSystemFontOfSize(20)
        lbFen.textColor = AppLineBgColor
        self.addSubview(lbFen)
        lbFen.snp_makeConstraints { (make) in
            make.left.equalTo(390)
            make.top.equalTo(360)
        }
        
        let btnJian = UIButton()
        btnJian.setBackgroundImage(UIImage(named: "jian"), forState:UIControlState.Normal)
        btnJian.addTarget(self, action: #selector(DetailsView.btnJianClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btnJian)
        btnJian.snp_makeConstraints { (make) in
            make.top.equalTo(360)
            make.left.equalTo(420)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        let btnJia = UIButton()
        btnJia.setBackgroundImage(UIImage(named: "jia"), forState:UIControlState.Normal)
        btnJia.addTarget(self, action: #selector(DetailsView.btnJiaClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btnJia)
        btnJia.snp_makeConstraints { (make) in
            make.top.equalTo(360)
            make.left.equalTo(480)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    
        
        let productBigImage:UIImageView = UIImageView()
        productBigImage.sd_setImageWithURL(NSURL(string: "http://1.nnbetter.com:8029/uploadFiles/\(currentProduct.ImgName)"))
        productBigImage.layer.borderWidth = 1
        productBigImage.layer.borderColor = AppLineBgColor.CGColor
        self.addSubview(productBigImage)
        productBigImage.snp_makeConstraints { (make) in
            make.top.equalTo(400)
            make.left.equalTo(40)
            make.width.equalTo(528)
            make.height.equalTo(360)
        }
    }
    
    override func reloadInputViews() {
        
        var pCount = "0";
        if(CartTools.checkCartIsExist())
        {
            let cart:CartModel =  CartTools.getCurrentCart()
            for pItem in cart.List {
                if(pItem.Item.CName == currentProduct.CName)
                {
                    pCount = "\(pItem.Count)"
                    break;
                }
            }
        }
        
        txtYiDian.text = "\(pCount)"
        txtYiDian.textColor = AppProductPriceTextColor
        txtYiDian.layer.cornerRadius = 5
        txtYiDian.font = UIFont.boldSystemFontOfSize(20)
        txtYiDian.textAlignment = NSTextAlignment.Center
        txtYiDian.layer.borderWidth = 1
        txtYiDian.layer.borderColor = AppLineBgColor.CGColor
        self.addSubview(txtYiDian)
        txtYiDian.snp_makeConstraints { (make) in
            make.left.equalTo(345)
            make.top.equalTo(360)
            make.width.equalTo(40)
        }
    }
    
    func btnJianClicked(sender:UIButton)
    {
        if(CartTools.checkCartIsExist())
        {
            let cart:CartModel =  CartTools.getCurrentCart()
            cart.removeProductOne(RemoveProduct: currentProduct)
            CartTools.setCart(cart)
            reloadInputViews()
        }else{
           ViewAlertTextCommon.ShowSimpleText("尚未开单，请先开单", view: self)
        }
    }
    
    func btnJiaClicked(sender:UIButton)
    {
        if(CartTools.checkCartIsExist())
        {
            let cart:CartModel =  CartTools.getCurrentCart()
            cart.addProduct(AddProduct: currentProduct)
            CartTools.setCart(cart)
            reloadInputViews()
        }else //购物车不存在
        {
            ViewAlertTextCommon.ShowSimpleText("尚未开单，请先开单", view: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
