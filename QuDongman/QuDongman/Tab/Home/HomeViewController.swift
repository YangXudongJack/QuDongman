//
//  HomeViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 27/10/2017.
//  Copyright © 2017 JackYang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableview: UITableView?
    var datasource: NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "趣动漫"
        self.view.backgroundColor = UIColor.white
        
        let size = self.view.bounds.size
        let navHeight = self.navigationController?.navigationBar.frame.size.height
        var frame:CGRect?
        if #available(iOS 11.0, *) {
            frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - navHeight! - 50 - UIApplication.shared.statusBarFrame.size.height)
        } else {
            frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - navHeight! - UIApplication.shared.statusBarFrame.size.height)
        }
        
        tableview = UITableView.init(frame: frame!, style: UITableViewStyle.plain)
        tableview?.delegate = self
        tableview?.dataSource = self
        tableview?.showsVerticalScrollIndicator = false
        tableview?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableview!)
        
        initData()
    }
    
    func initData() -> Void {
//        let bundlePath = Bundle.main.bundlePath
//        let plistName = "/HomeData.plist"
//        let filePath = bundlePath.appending(plistName)
//
//        datasource = NSMutableArray.init(contentsOfFile: filePath)
//        tableview?.reloadData()
        
        datasource = NSMutableArray.init()
        HttpUnit.HttpGet(url: JYUrl.home() ) { (response, status) in
            if status {
                let books = response.object(forKey: "data")
                for item in books as! NSArray {
                    let cartoon = JYBanner.init(dict: item as! [String : AnyObject])
                    self.datasource?.add(cartoon)
                }
                self.tableview?.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataInfo = datasource![indexPath.row]
        let cell = JYHomeCell.createCell(tableview: tableView, info: dataInfo as! JYBanner, indexPath: indexPath as NSIndexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0 * UIScreen.main.bounds.size.width / 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataInfo = datasource![indexPath.row]
        let detail:CartoonDetailViewController = CartoonDetailViewController()
        detail.dictionary = dataInfo as? NSDictionary
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
