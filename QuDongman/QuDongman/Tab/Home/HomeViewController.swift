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
    var homeDataSource: JYHome?
    var page: Int?
    var dataEnable:Bool?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.NavigationColor()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        showTabbar()
        let nav:JYNavigationController = self.navigationController as! JYNavigationController
        nav.resetConfig()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "趣动漫"
        self.view.backgroundColor = UIColor.white
        
        dataEnable = false
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.NavigationColor()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let nav:JYNavigationController = self.navigationController as! JYNavigationController
        nav.resetConfig()
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
                if books.isKind(of: NSDictionary.self) {
//                    if books.count < 4 {
//                        self.loadEnable = false
//                    }
                    
//                    for item in books as! NSArray {
//                        let cartoon = JYBanner.init(dict: item as! [String : AnyObject])
//                        self.datasource?.add(cartoon)
//                    }
                    self.dataEnable = true
                    self.homeDataSource = JYHome.init(dict: books as! [String : AnyObject])
                    self.tableview?.reloadData()
                }
                JYProgressHUD.dismiss()
            }
        }
    }
    
    func numberOfRows() -> Int {
        if self.dataEnable! {
            return 1 + (self.homeDataSource?.recommend_results?.count)! * 2
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let identifier = "JYCoverCell"
//        let cell:JYCoverCell! = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? JYCoverCell
//        cell.book = self.datasource?.object(at: indexPath.row) as! JYBanner
//        cell.index = indexPath.row
//        return cell
        
        if indexPath.row == 0 {
            let cell = JYBannerCell.createCell(tableview: tableView) { (recommend) in
                let detail = BookDetailController.create()
                detail.id = recommend.id
                self.navigationController?.pushViewController(detail, animated: true)
            }
            cell.banners = (self.homeDataSource?.banner_results)!
            return cell
        }else if indexPath.row == 1 {
            let cell = JYNavCell.createCell(tableview: tableView) { (nav) in
                let story = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                let detail:SearchDetailController = story.instantiateViewController(withIdentifier: "SearchDetailController") as! SearchDetailController
                if nav.nav_name == "免费" {
                    detail.is_vip = "0"
                }
                if nav.nav_name == "短篇" {
                    detail.is_short = "1"
                }
                detail.title = nav.nav_name
                detail.onlyRank = true
                self.navigationController?.pushViewController(detail, animated: true)
            }
            cell.navs = self.homeDataSource?.nav_results
            return cell
        }else if (indexPath.row % 2 == 0 && indexPath.row > 1){
            let cell = JYNewHomeCell.createCell(tableview: tableView) { (recommend) in
                let detail = BookDetailController.create()
                detail.id = recommend.id
                self.navigationController?.pushViewController(detail, animated: true)
            }
            let index:Int = (indexPath.row - 2) / 2
            let recommend:JYRecommend = self.homeDataSource?.recommend_results?.object(at: index) as! JYRecommend
            cell.recommends = recommend.recommend_results
            return cell
        }else{
            let cell = JYBannerCell.createCell(tableview: tableView) { (recommend) in
                let detail = BookDetailController.create()
                detail.id = recommend.id
                self.navigationController?.pushViewController(detail, animated: true)
            }
            let index:Int = (indexPath.row - 1) / 2
            let recommend:JYRecommend = self.homeDataSource?.recommend_results?.object(at: index) as! JYRecommend
            let banners = NSMutableArray()
            banners.add(recommend.top_result!)
            cell.banners = banners
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 160.0 * UIScreen.main.bounds.size.width / 320
        if indexPath.row == 0 {
            return 175.0
        }else if indexPath.row == 1{
            return 93.0
        }else if indexPath.row % 2 == 0{
            return 343.0
        }else{
            return 175.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let dataInfo = datasource![indexPath.row]
//        let detail = BookDetailController.create()
//        detail.banner = dataInfo as? JYBanner
//        self.navigationController?.pushViewController(detail, animated: true)
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let offset = (self.tableview?.contentOffset.y)! - ((self.tableview?.contentSize.height)! - (self.tableview?.bounds.size.height)!)
//        if offset == 0 && self.loadEnable!{
//            self.page = self.page! + 1
//            self.initData()
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
