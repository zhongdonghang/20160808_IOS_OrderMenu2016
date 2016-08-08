//
//  MainLeftMenuView.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/7/20.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol LeftMenuClicked {
    func menuSelected(menuId:String)
}

class MainLeftMenuView: UIView,UITableViewDelegate,UITableViewDataSource {

    var tbData:[ProductCateoryViewModel] = []
    
    let dbTable:UITableView = UITableView()
    var delegate:LeftMenuClicked?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.frame = frame
        dbTable.frame = frame
        dbTable.dataSource = self
        dbTable.delegate = self
        
        dbTable.separatorStyle = UITableViewCellSeparatorStyle.None
        dbTable.backgroundColor = UIColor.clearColor()
        dbTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.addSubview(dbTable)
        
        loadList()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadList() {
        let url = AppServerURL+"GetProductCateoryList"
        let parameters = [
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
                    self.tbData.removeAll()
                    for obj in json["Page"]["Data"]
                    {
                        let vm:ProductCateoryViewModel = ProductCateoryViewModel()
                        vm.OID = "\(obj.1["OID"])"
                        vm.CNAME = "\(obj.1["CName"])"
                        self.tbData.append(vm)
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
        return 40
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tbData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        let leiBieIcon:UIImageView = UIImageView(image: UIImage(named: "leibie_01"))
        cell.contentView.addSubview(leiBieIcon)
        leiBieIcon.snp_makeConstraints { (make) in
            make.left.equalTo(2)
            make.centerY.equalTo(cell.contentView)
        }
        
        let lbText = UILabel()
        lbText.text = tbData[indexPath.row].CNAME
        cell.contentView.addSubview(lbText)
        lbText.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(30)
            make.centerY.equalTo(cell.contentView)
        })
        

        let lineView:UIView = UIView()
        lineView.backgroundColor = AppLineBgColor
        cell.contentView.addSubview(lineView)
        lineView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.visibleCells[indexPath.row].contentView.backgroundColor = AppLeftMenuSelectBgColor

        self.delegate?.menuSelected(tbData[indexPath.row].OID)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
