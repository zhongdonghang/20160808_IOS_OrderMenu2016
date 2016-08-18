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

//点击商品显示详情的回调委托
protocol ProductClicked {
    func ProductSelected(product:ProductSimpleViewModel)
}

//当前购物车不存在的回调委托（要新开单）
protocol CartNotExist
{
    func newCart()
}

class MainRightMenuView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CellClicked,CurrentCartNotExist {

    var myView:UICollectionView!
    var delegateProductSelected:ProductClicked!
    
    var delegateNewCart:CartNotExist!
   
    var tbData:[ProductSimpleViewModel] = []
    var menuId = "0"
    
    init(frame: CGRect,menuid:String)
    {
        super.init(frame: frame)
        menuId = menuid
        self.backgroundColor = UIColor.clearColor()
        let layout = UICollectionViewFlowLayout()
        myView = UICollectionView(frame: (frame: CGRectMake(0, 0, self.bounds.width, self.bounds.height)),collectionViewLayout: layout)
        myView.registerClass(ProductViewCell.self, forCellWithReuseIdentifier: "mycell")
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("mycell", forIndexPath: indexPath) as! ProductViewCell
        cell.Product = tbData[indexPath.row]
        cell.layoutSubviews()
        
        cell.delgateCellClicked = self
        cell.delgateCurrentCartNotExist = self
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

    func CellSelected(product:ProductSimpleViewModel)
    {
         self.delegateProductSelected?.ProductSelected(product)
    }
    
    func openCart()
    {
        delegateNewCart.newCart()
    }

}
