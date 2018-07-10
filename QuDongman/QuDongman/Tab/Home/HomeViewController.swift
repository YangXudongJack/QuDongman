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
    var page: Int?
    var loadEnable:Bool?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.NavigationColor()
        self.navigationController?.navigationBar.isTranslucent = false
        showTabbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "趣动漫"
        self.view.backgroundColor = UIColor.white
        
        loadEnable = true
        datasource = NSMutableArray.init()
        let size = UIScreen.main.bounds.size
        let navHeight = self.navigationController?.navigationBar.frame.size.height
        var frame:CGRect?
        if #available(iOS 11.0, *) {
            var fixHeight:CGFloat = 0
            if DeviceManager.isIphoneX() {
                fixHeight = 20
            }
            
            frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - navHeight! - 50 - UIApplication.shared.statusBarFrame.size.height - fixHeight)
        } else {
            frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - navHeight! - UIApplication.shared.statusBarFrame.size.height)
        }
        
        tableview = UITableView.init(frame: frame!, style: UITableViewStyle.plain)
        tableview?.delegate = self
        tableview?.dataSource = self
        tableview?.showsVerticalScrollIndicator = false
        tableview?.separatorStyle = UITableViewCellSeparatorStyle.none
        tableview?.register(UINib.init(nibName: "JYCoverCell", bundle: Bundle.main), forCellReuseIdentifier: "JYCoverCell")
        self.view.addSubview(tableview!)
        
        page = 1
        initData()
    }
    
    func initData() -> Void {
//        let bundlePath = Bundle.main.bundlePath
//        let plistName = "/HomeData.plist"
//        let filePath = bundlePath.appending(plistName)
//
//        datasource = NSMutableArray.init(contentsOfFile: filePath)
//        tableview?.reloadData()
        
        JYProgressHUD.show()
        HttpUnit.HttpGet(url: JYUrl.home(page: page!) ) { (response, status) in
            if status {
                let books:AnyObject = response.object(forKey: "data") as AnyObject
                if books.isKind(of: NSArray.self) {
//                    if books.count < 4 {
//                        self.loadEnable = false
//                    }
                    
                    for item in books as! NSArray {
                        let cartoon = JYBanner.init(dict: item as! [String : AnyObject])
                        self.datasource?.add(cartoon)
                    }
                    self.tableview?.reloadData()
                }else{
                    self.loadEnable = false
                }
                JYProgressHUD.dismiss()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "JYCoverCell"
        let cell:JYCoverCell! = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? JYCoverCell
        cell.book = self.datasource?.object(at: indexPath.row) as! JYBanner
        cell.index = indexPath.row
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0 * UIScreen.main.bounds.size.width / 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataInfo = datasource![indexPath.row]
        let detail = BookDetailController.create()
        detail.banner = dataInfo as? JYBanner
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = (self.tableview?.contentOffset.y)! - ((self.tableview?.contentSize.height)! - (self.tableview?.bounds.size.height)!)
        if offset == 0 && self.loadEnable!{
            self.page = self.page! + 1
            self.initData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
