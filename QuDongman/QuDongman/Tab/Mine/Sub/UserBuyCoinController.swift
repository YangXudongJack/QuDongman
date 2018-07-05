//
//  UserBuyCoinController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/4/21.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class UserBuyCoinController: UITableViewController {

    var dataSource:NSMutableArray?
    var product:JYProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "购买阅读币"
        createNavBackBtn()
        
        weak var weakself = self
        dataSource = NSMutableArray.init()
        initData {
            JYProgressHUD.dismiss()
            weakself?.tableView.reloadSections([0], with: .fade)
        }
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
    }
    
    func initData(colsure:@escaping () -> Void) -> Void {
        JYProgressHUD.show()
        weak var weakself = self
        HttpUnit.HttpGet(url: JYUrl.product()) { (response, success) in
            let data:NSArray = response.object(forKey: "data") as! NSArray
            for item in data {
                weakself?.dataSource?.add(JYProduct.init(dict: item as! [String : AnyObject]))
            }
            weakself?.product = weakself?.dataSource?.firstObject as! JYProduct
            colsure()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (dataSource?.count)!
        }else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return JYBuyCoinCell.cellHeight()
        }else{
            return 65.0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var weakself = self
        let cell = JYBuyCoinCell.createCell(tableview: tableView)
        if indexPath.section == 0 {
            cell.info = dataSource?.object(at: indexPath.row) as AnyObject
        }else{
            cell.info = "" as AnyObject
        }
        cell.price = product?.total_fee_descp
        cell.selectColsure { (product, coinType) in
            if coinType == .price {
                weakself?.product = product as! JYProduct
                weakself?.tableView.reloadData()
            }else{
                PayManager.shared.pay(type: .ali, product: (weakself?.product)!)
            }
        }
        return cell
    }

}
