//
//  CartoonDetailViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/14.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import UIKit

class CartoonDetailViewController: UITableViewController {

    var dictionary:NSDictionary?
    var book_result:NSDictionary?
    var chapter_results:NSArray?
    var loadtag:Bool = true
    var id:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "漫画详情"
        createNavBackBtn()
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        let id_t = dictionary?.object(forKey: "id")
        id = (id_t as! NSString).integerValue
        HttpUnit.HttpGet(url: JYUrl.detail(id:id!)) { (response, status) in
            if status {
                let data = response.object(forKey: "data")
                self.book_result = (data as! NSDictionary).object(forKey: "book_result") as? NSDictionary
                
                self.chapter_results = (data as! NSDictionary).object(forKey: "chapter_results") as? NSArray
                
                self.loadtag = false
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabbar: JYTabbarController = UIApplication.shared.keyWindow?.rootViewController as! JYTabbarController
        tabbar.hideTabbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let tabbar: JYTabbarController = UIApplication.shared.keyWindow?.rootViewController as! JYTabbarController
        tabbar.showTabbar()
    }
    
    func readActionClosure() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loadtag {
            return 0
        }else{
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let cell : CartoonCoverCell = self.tableView(tableView, cellForRowAt: indexPath) as! CartoonCoverCell;
            return cell.cellHeight()
        }else{
            let cell : CartoonCatelogCell = self.tableView(tableView, cellForRowAt: indexPath) as! CartoonCatelogCell;
            return cell.cellHeight()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var weakSelf = self
        if indexPath.row == 0 {
            let cell : CartoonCoverCell = CartoonCoverCell.createCell(tableview: tableView, info: book_result!)
            cell.readClickColsure {
                if weakSelf?.chapter_results?.count != 0 {
                    let cartoon: CartoonViewController = CartoonViewController()
                    cartoon.id = self.id
                    let info = weakSelf?.chapter_results?.firstObject as! NSDictionary
                    cartoon.chapter = (info.object(forKey: "id") as! NSString).integerValue
                    cartoon.title = info.object(forKey: "name") as? String
                    weakSelf?.navigationController?.pushViewController(cartoon, animated: true)
                }
            };
            return cell
        }else{
            let cell : CartoonCatelogCell = CartoonCatelogCell.createCell(tableview: tableView, info: chapter_results!)
            cell.readClickColsure(colsure: { (tag) in
                let cartoon: CartoonViewController = CartoonViewController()
                cartoon.id = weakSelf?.id
                let info = weakSelf?.chapter_results?.object(at: tag - 1) as! NSDictionary
                cartoon.chapter = (info.object(forKey: "id") as! NSString).integerValue
                cartoon.title = info.object(forKey: "name") as? String
                weakSelf?.navigationController?.pushViewController(cartoon, animated: true)
            })
            return cell
        }
    }
 

}
