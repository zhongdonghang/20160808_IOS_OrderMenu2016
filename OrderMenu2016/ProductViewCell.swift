//
//  ProductViewCell.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/8/13.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit

//点击商品显示详情的回调委托
protocol CellClicked {
    func CellSelected(product:ProductSimpleViewModel)
}

protocol CurrentCartNotExist
{
    func openCart()
}

//商品详情cell
class ProductViewCell: UICollectionViewCell {
    
    var delgateCellClicked:CellClicked!
    var delgateCurrentCartNotExist:CurrentCartNotExist!

    var _product:ProductSimpleViewModel!
    let productImageView = UIImageView()
    let btnProduct:UIButton = UIButton()
    let productDescView:UIView = UIView()
    let lbPName:UILabel = UILabel()
    let lbPPrice:UILabel = UILabel()
    let lbYiDian:UILabel = UILabel()
    let txtYiDian:UITextField = UITextField()
    let lbFen:UILabel = UILabel()
    let btnJian:UIButton = UIButton()
    let btnJia:UIButton = UIButton()
    
    var Product: ProductSimpleViewModel! {
        didSet {
            _product = Product
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //初始化各种控件
        self.contentView.backgroundColor = UIColor.clearColor()
        
        //商品图片
        productImageView.sd_setImageWithURL( NSURL(string: "\(AppServer)uploadFiles/\(_product.ImgName)"))
        productImageView.layer.borderWidth = 1
        productImageView.layer.borderColor = AppLineBgColor.CGColor
        self.contentView.addSubview(productImageView)
        productImageView.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-50)
        }
        
        //商品按钮
        btnProduct.backgroundColor = UIColor.clearColor()
        btnProduct.addTarget(self, action: #selector(ProductViewCell.btnProductClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(btnProduct)
        btnProduct.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-90)
        }
        
       //商品描述（阴影）
        productDescView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.contentView.addSubview(productDescView)
        productDescView.snp_makeConstraints { (make) in
            make.top.equalTo(210)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        
        //商品名字
        lbPName.text = _product.CName
        lbPName.textColor = UIColor.whiteColor()
        productDescView.addSubview(lbPName)
        lbPName.snp_makeConstraints { (make) in
            make.centerY.equalTo(productDescView)
            make.left.equalTo(5)
        }
        
        //商品价格
        lbPPrice.text = "\(_product.Price1)元"
        lbPPrice.textColor = UIColor.whiteColor()
        productDescView.addSubview(lbPPrice)
        lbPPrice.snp_makeConstraints { (make) in
            make.centerY.equalTo(productDescView)
            make.right.equalTo(-5)
        }
        
        //已点文字
        lbYiDian.text = "已点"
        lbYiDian.textColor = AppLineBgColor
        self.contentView.addSubview(lbYiDian)
        lbYiDian.snp_makeConstraints { (make) in
            make.left.equalTo(5)
            make.bottom.equalTo(-20)
        }
        
        var pCount = "0";
        if(CartTools.checkCartIsExist())
        {
            let cart:CartModel =  CartTools.getCurrentCart()
            for pItem in cart.List {
                if(pItem.Item.CName == _product.CName)
                {
                    pCount = "\(pItem.Count)"
                    pCount = CommonTools.quxiaoshudianhoudeling(pCount)
                    break;
                }
            }
        }
        
        //已点数量
        txtYiDian.text = pCount
        txtYiDian.layer.cornerRadius = 5
        txtYiDian.textAlignment = NSTextAlignment.Center
        txtYiDian.layer.borderWidth = 1
        txtYiDian.layer.borderColor = AppLineBgColor.CGColor
        self.contentView.addSubview(txtYiDian)
        txtYiDian.snp_makeConstraints { (make) in
            make.left.equalTo(40)
            make.bottom.equalTo(-20)
            make.width.equalTo(40)
        }
        
       //份文字
        lbFen.text = "份"
        lbFen.textColor = AppLineBgColor
        self.contentView.addSubview(lbFen)
        lbFen.snp_makeConstraints { (make) in
            make.left.equalTo(85)
            make.bottom.equalTo(-20)
        }
        
        //"减"按钮
        btnJian.setBackgroundImage(UIImage(named: "jian"), forState: UIControlState.Normal)
        btnJian.addTarget(self, action: #selector(ProductViewCell.btnJianClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(btnJian)
        btnJian.snp_makeConstraints { (make) in
            make.left.equalTo(130)
            make.bottom.equalTo(-10)
            make.width.equalTo(54)
            make.height.equalTo(34)
        }
        
        //“加”按钮
        btnJia.setBackgroundImage(UIImage(named: "jia"), forState: UIControlState.Normal)
        btnJia.addTarget(self, action: #selector(ProductViewCell.btnJiaClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(btnJia)
        btnJia.snp_makeConstraints { (make) in
            make.right.equalTo(-2)
            make.bottom.equalTo(-10)
            make.width.equalTo(54)
            make.height.equalTo(34)
        }
    }
    
    func  btnJianClicked(sender:UIButton) {
        if(CartTools.checkCartIsExist())
        {
            let cart:CartModel =  CartTools.getCurrentCart()
            cart.removeProductOne(RemoveProduct: _product)
            CartTools.setCart(cart)
            layoutSubviews()
        }else{
            delgateCurrentCartNotExist.openCart()
        }
    }
    
    func btnJiaClicked(sender:UIButton)
    {
        if(CartTools.checkCartIsExist())
        {
            SoundManager().playHit()
            let cart:CartModel =  CartTools.getCurrentCart()
            cart.addProduct(AddProduct: _product)
            CartTools.setCart(cart)
            layoutSubviews()
        }else //购物车不存在
        {
            delgateCurrentCartNotExist.openCart()
        }

    }
    
    func btnProductClicked(sender:UIButton) {
        delgateCellClicked.CellSelected(self._product)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
