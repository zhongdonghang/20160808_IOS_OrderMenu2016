//
//  MainRightMenuView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/21.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol ProductClicked {
    func ProductSelected(product:ProductSimpleViewModel)
}

class MainRightMenuView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var myView:UICollectionView!
    var delegate:ProductClicked!
    var tbData:[ProductSimpleViewModel] = []
    var menuId = "0"
    
    init(frame: CGRect,menuid:String)
    {
        super.init(frame: frame)
        menuId = menuid
        self.backgroundColor = UIColor.clearColor()
        let layout = UICollectionViewFlowLayout()
        myView = UICollectionView(frame: (frame: CGRectMake(0, 0, self.bounds.width, self.bounds.height)),collectionViewLayout: layout)
        myView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "mycell")
        myView.backgroundColor = UIColor.clearColor()
        myView.dataSource = self
        myView.delegate = self
        self.addSubview(myView)
        
        loadList()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadList() {
        let url = AppServerURL+"GetProductListByPCategory"
        let parameters = [
            "_pageIndex": "0",
            "_pageSize": "1000",
            "_oid": "\(menuId)",
            "_orgid": LoginUserTools.getCurrentOrgId()
        ]
        print(parameters)
        let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
        hud.label.text = "loading..."
        Alamofire.request(.GET, url,parameters: parameters).responseJSON { (response) in
            switch response.result {
            case.Success(let data):
                let json = JSON(data)
                if(json["ResultCode"] == "200")//请求成功
                {
                    self.tbData.removeAll()
                    for obj in json["Page"]["Data"]
                    {
                        let vm:ProductSimpleViewModel = ProductSimpleViewModel()
                        vm.OID = "\(obj.1["OID"])"
                         vm.CName = "\(obj.1["CName"])"
                         vm.Price1 = "\(obj.1["Price1"])"
                         vm.Price2 = "\(obj.1["Price2"])"
                         vm.PIngredients = "\(obj.1["PIngredients"])"
                         vm.PContent = "\(obj.1["PContent"])"
                         vm.PPractice = "\(obj.1["PPractice"])"
                         vm.ImgName = "\(obj.1["ImgName"])"
                        self.tbData.append(vm)
                    }
                  self.myView.reloadData()
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return tbData.count
    }
    

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("mycell", forIndexPath: indexPath)
        cell.contentView.backgroundColor = UIColor.clearColor()
        let productImageView:UIImageView = UIImageView()
        productImageView.sd_setImageWithURL( NSURL(string: "http://1.nnbetter.com:8029/uploadFiles/\(tbData[indexPath.row].ImgName)"))
      //  productImageView.sd_setImageWithURL( nil)
        productImageView.layer.borderWidth = 1
        productImageView.layer.borderColor = AppLineBgColor.CGColor
        cell.contentView.addSubview(productImageView)
        productImageView.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-50)
        }
        
        let btnProduct:UIButton = UIButton()
        btnProduct.tag = indexPath.row
        btnProduct.backgroundColor = UIColor.clearColor()
        btnProduct.addTarget(self, action: #selector(MainRightMenuView.btnProductClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.contentView.addSubview(btnProduct)
        btnProduct.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-90)
        }
        let productDescView:UIView = UIView()
        productDescView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        cell.contentView.addSubview(productDescView)
        productDescView.snp_makeConstraints { (make) in
            make.top.equalTo(210)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        
        
        
        
        let lbPName:UILabel = UILabel()
        lbPName.text = tbData[indexPath.row].CName
        lbPName.textColor = UIColor.whiteColor()
        productDescView.addSubview(lbPName)
        lbPName.snp_makeConstraints { (make) in
            make.centerY.equalTo(productDescView)
            make.left.equalTo(5)
        }
        
        let lbPPrice:UILabel = UILabel()
        lbPPrice.text = tbData[indexPath.row].Price1
        lbPPrice.textColor = UIColor.whiteColor()
        productDescView.addSubview(lbPPrice)
        lbPPrice.snp_makeConstraints { (make) in
            make.centerY.equalTo(productDescView)
            make.right.equalTo(-5)
        }
        
        let lbYiDian:UILabel = UILabel()
        lbYiDian.text = "已点"
        lbYiDian.textColor = AppLineBgColor
        cell.contentView.addSubview(lbYiDian)
        lbYiDian.snp_makeConstraints { (make) in
            make.left.equalTo(5)
            make.bottom.equalTo(-20)
        }
        
        let txtYiDian:UITextField = UITextField()
        txtYiDian.text = "1"
        txtYiDian.layer.cornerRadius = 5
        txtYiDian.textAlignment = NSTextAlignment.Center
        txtYiDian.layer.borderWidth = 1
        txtYiDian.layer.borderColor = AppLineBgColor.CGColor
        cell.contentView.addSubview(txtYiDian)
        txtYiDian.snp_makeConstraints { (make) in
            make.left.equalTo(40)
            make.bottom.equalTo(-20)
            make.width.equalTo(40)
        }
        
        let lbFen:UILabel = UILabel()
        lbFen.text = "份"
        lbFen.textColor = AppLineBgColor
        cell.contentView.addSubview(lbFen)
        lbFen.snp_makeConstraints { (make) in
            make.left.equalTo(85)
            make.bottom.equalTo(-20)
        }
        
        let btnJian:UIButton = UIButton()
        btnJian.tag = indexPath.row
        btnJian.addTarget(self, action: #selector(MainRightMenuView.btnJianClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnJian.setBackgroundImage(UIImage(named: "jian"), forState: UIControlState.Normal)
        cell.contentView.addSubview(btnJian)
        btnJian.snp_makeConstraints { (make) in
            make.left.equalTo(130)
            make.bottom.equalTo(-10)
            make.width.equalTo(54)
            make.height.equalTo(34)
        }
        
        let btnJia:UIButton = UIButton()
        btnJia.tag = indexPath.row
        btnJia.addTarget(self, action: #selector(MainRightMenuView.btnJiaClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnJia.setBackgroundImage(UIImage(named: "jia"), forState: UIControlState.Normal)
        cell.contentView.addSubview(btnJia)
        btnJia.snp_makeConstraints { (make) in
            make.right.equalTo(-2)
            make.bottom.equalTo(-10)
            make.width.equalTo(54)
            make.height.equalTo(34)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(250, 300)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func btnProductClick(sender:UIButton) {
        
        self.delegate?.ProductSelected(tbData[sender.tag])
    }
    
    func btnJianClicked(sender:UIButton) {
        print("-\(sender.tag)")
    }
    
    func btnJiaClicked(sender:UIButton) {
        print("+\(sender.tag)")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
