//
//  CartoonDetailViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/14.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import UIKit

class CartoonDetailViewController: UITableViewController {

    var detail:JYBanner?
//    var book_result:NSDictionary?
//    var chapter_results:NSArray?
    var bookInfo:JYCartoon?
    var loadtag:Bool = true
    var id:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "漫画详情"
        createNavBackBtn()
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        id = (detail?.id! as! NSString).integerValue
        HttpUnit.HttpGet(url: JYUrl.detail(id:Int((detail?.id)!)!)) { (response, status) in
            if status {
                let data = response.object(forKey: "data")
//                self.book_result = (data as! NSDictionary).object(forKey: "book_result") as? NSDictionary
//
//                self.chapter_results = (data as! NSDictionary).object(forKey: "chapter_results") as? NSArray
                
                self.bookInfo = JYCartoon.init(dict: data as! [String : AnyObject])
                
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
            let cell : CartoonCoverCell = CartoonCoverCell.createCell(tableview: tableView)
            cell.info = bookInfo
            cell.readClickColsure {
                if weakSelf?.bookInfo?.chapter_results?.count != 0 {
                    let cartoon: CartoonViewController = CartoonViewController()
                    
                    cartoon.id = self.id
                    let info = weakSelf?.bookInfo?.chapter_results?.first as! JYCatelog
                    cartoon.chapter = (info.id as! NSString).integerValue
                    cartoon.title = info.name
                    weakSelf?.navigationController?.pushViewController(cartoon, animated: true)
                }
            };
            return cell
        }else{
            let cell : CartoonCatelogCell = CartoonCatelogCell.createCell(tableview: tableView)
            cell.info = bookInfo
            cell.readClickColsure(colsure: { (tag) in
                let cartoon: CartoonViewController = CartoonViewController()
                cartoon.id = weakSelf?.id
                let info = weakSelf?.bookInfo?.chapter_results?[tag - 1] as! JYCatelog
                cartoon.chapter = (info.id as! NSString).integerValue
                cartoon.title = info.name
                weakSelf?.navigationController?.pushViewController(cartoon, animated: true)
            })
            return cell
        }
    }
 

}
