//
//  CartoonViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 02/11/2017.
//  Copyright © 2017 JackYang. All rights reserved.
//

import UIKit
import Alamofire

class CartoonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var id:Int?
    var chapter:Int?
    var datasource:NSMutableArray?
    var tableview:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBackBtn()
        
        let size = self.view.bounds.size
        let navHeight = self.navigationController?.navigationBar.frame.size.height
        let statusHeight = UIApplication.shared.statusBarFrame.height
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - navHeight! - statusHeight)
        tableview = UITableView.init(frame: frame, style: UITableViewStyle.plain)
        tableview?.delegate = self
        tableview?.dataSource = self
        tableview?.showsVerticalScrollIndicator = true
        tableview?.separatorStyle = UITableViewCellSeparatorStyle.none
        tableview?.separatorStyle = .none
        tableview?.showsVerticalScrollIndicator = false
        
        self.view.addSubview(tableview!)
        
        datasource = NSMutableArray.init()
        
        HttpUnit.HttpGet(url: JYUrl.content(id: id!, chapter: chapter!)) { (response, status) in
            if status {
                let contents : NSArray = (response.object(forKey: "data") as? NSArray)!
                self.datasource = NSMutableArray.init(array: contents)
                self.tableview?.reloadData()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 427.0 * (UIScreen.main.bounds.size.width / 320.0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datasource == nil {
            return 0
        }else{
            return (datasource?.count)!
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CartoonContentCell = CartoonContentCell.createCell(tableview: tableView)
        cell.imageName = datasource?.object(at: indexPath.row) as! String
        return cell
    }

}
