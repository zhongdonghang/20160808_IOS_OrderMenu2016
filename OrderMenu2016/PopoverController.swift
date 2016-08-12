//
//  PopoverController.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/8/12.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import UIKit
import SnapKit

///已经选择完服务员委托
protocol IFuWuYuanChecked {
    func FuWuYuanChecked(emp:EmpModel)
}

class PopoverController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var delgateIFuWuYuanChecked:IFuWuYuanChecked!
    var empAr:[EmpModel] = []
    let dbTable:UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbTable.frame = self.view.frame
        dbTable.dataSource = self
        dbTable.delegate = self
        
        dbTable.separatorStyle = UITableViewCellSeparatorStyle.None
        dbTable.backgroundColor = UIColor.clearColor()
        dbTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.view.addSubview(dbTable)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 40
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return empAr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
       
        let lbText = UILabel()
        lbText.text = empAr[indexPath.row].Cname
        cell.contentView.addSubview(lbText)
        lbText.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(30)
            make.centerY.equalTo(cell.contentView)
        })
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        delgateIFuWuYuanChecked.FuWuYuanChecked(empAr[indexPath.row])
        self.dismissViewControllerAnimated(false, completion: nil)
    }

}
