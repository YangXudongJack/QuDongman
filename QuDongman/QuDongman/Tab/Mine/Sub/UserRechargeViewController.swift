//
//  UserRechargeViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/5/20.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class UserRechargeViewController: UITableViewController {

    var typeShopping:Bool?
    var tableview:UITableView?
    var dataSource:NSMutableArray?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        hideTabbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if typeShopping! {
            self.title = "消费记录"
        }else{
            self.title = "充值记录"
        }
        
        createNavBackBtn()
        tableView.separatorStyle = .none
        
        weak var weakself = self
        dataSource = NSMutableArray.init()
        initData {
            weakself?.tableView.reloadSections([0], with: .fade)
        }
    }
    
    func initData(colsure:@escaping () -> Void) -> Void {
        weak var weakself = self
        HttpUnit.HttpGet(url: JYUrl.record(isShopping: typeShopping!)) { (response, success) in
            let data:AnyObject = response.object(forKey: "data") as AnyObject
            if data .isKind(of: NSArray.self) {
                for item in data as! NSArray{
                    weakself?.dataSource?.add(JYRecharge.init(dict: item as! [String : AnyObject]))
                }
                
                colsure()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RechargeRecodeCell.createCell(tableview: tableView)
        cell.shoppingType = typeShopping!
        cell.object = dataSource?.object(at: indexPath.row) as! JYBaseObject
        return cell
    }

}
