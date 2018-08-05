//
//  SearchDetailController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/6/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class SearchDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var statusbarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchBarBackviewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var categoriesBackground: UIView!
    
    @IBOutlet weak var categoriesButtonsBackgroundHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var otherOptionButtonsBackview: UIView!
    
    @IBOutlet weak var otherOptionButtonsBackviewTopConstraint: NSLayoutConstraint!
    
    var categoriesButton:NSMutableArray!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var tableviewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var allButton: UIButton!
    
    @IBOutlet weak var serialButton: UIButton!
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet var bookSerialButtons: [UIButton]!
    
    @IBOutlet weak var allRankButton: UIButton!
    
    @IBOutlet weak var clickRankButton: UIButton!
    
    @IBOutlet weak var payRankButton: UIButton!
    
    @IBOutlet weak var collectRankButton: UIButton!
    
    @IBOutlet var rankButtons: [UIButton]!
    
    var onlyRank:Bool = false
    
    var page:Int = 0
    var key:String = ""
    var cat_id:String = ""
    var finish_status:String = ""
    var sort:String = ""
    var is_vip:String = ""
    var is_short:String = ""
    var tag_id:String = ""
    
    var categories:NSMutableArray?
    var books:NSMutableArray?
    
    var isConditionChange:Bool?
    var loadEnable:Bool?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let size = UIScreen.main.bounds.size
        loadEnable = true
        
        if onlyRank {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            for button in bookSerialButtons {
                button.isHidden = true
            }
            statusbarHeightConstraint.constant = 0
            categoriesButtonsBackgroundHeightConstraint.constant = 0
            searchBarBackviewHeightConstraint.constant = 0
            otherOptionButtonsBackviewTopConstraint.constant = -36
            self.view.insertSubview(otherOptionButtonsBackview, at: 0)
        }else{
            statusbarHeightConstraint.constant = UIApplication.shared.statusBarFrame.size.height
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
        
        tableviewHeightConstraint.constant = size.height - UIApplication.shared.statusBarFrame.size.height - 64 - (onlyRank ? -36 : categoriesButtonsBackgroundHeightConstraint.constant) - (DeviceManager.isIphoneX() ?20:0) - 80 + (onlyRank ? 12 : 0)
        hideTabbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if onlyRank {
            createNavBackBtn()
        }
        page = 1
        isConditionChange = false
        books = NSMutableArray.init()
        tableview.tableFooterView = UIView.init()
        tableview?.register(UINib.init(nibName: "JYCoverCell", bundle: Bundle.main), forCellReuseIdentifier: "JYCoverCell")
        
        configSubview()
        if !onlyRank {
            fetchCategory()
        }
        search()
    }
    
    func configSubview() -> Void {
        allButton.layer.cornerRadius = 18
        allButton.layer.masksToBounds = true
        allButton.layer.borderWidth = 1.0
        allButton.layer.borderColor = UIColor.NavigationColor().cgColor
        allButton.setTitleColor(UIColor.NavigationColor(), for: .normal)
        
        allRankButton.layer.cornerRadius = 18
        allRankButton.layer.masksToBounds = true
        allRankButton.layer.borderWidth = 1.0
        allRankButton.layer.borderColor = UIColor.NavigationColor().cgColor
        allRankButton.setTitleColor(UIColor.NavigationColor(), for: .normal)
    }
    
    func search() -> Void {
        JYProgressHUD.show()
        HttpUnit.HttpGet(url: JYUrl.search(page: page,
                                           key: key,
                                           cat_id: cat_id,
                                           finish_status: finish_status,
                                           sort: sort,
                                           is_vip: is_vip,
                                           is_short: is_short,
                                           tag_id: tag_id)) { (responseObject, success) in
                                            if success {
                                                if self.isConditionChange! {
                                                    self.books?.removeAllObjects()
                                                    self.isConditionChange = false
                                                }
                                                
                                                let temp:AnyObject = responseObject.object(forKey: "data") as AnyObject
                                                if temp.isKind(of: NSArray.self) {
                                                    let books:NSArray = temp as! NSArray
                                                    if books.count < 4 {
                                                        self.loadEnable = false
                                                    }
                                                    
                                                    for item in books {
                                                        self.books?.add(JYBanner.init(dict: item as! [String : AnyObject]))
                                                    }
                                                }else{
                                                    self.loadEnable = false
                                                }
                                                self.tableview.reloadData()
                                                JYProgressHUD.dismiss()
                                            }
        }
    }
    
    func fetchCategory() -> Void {
        self.categories = NSMutableArray.init()
        HttpUnit.HttpGet(url: JYUrl.category()) { (response, status) in
            if status {
                let categories:NSArray = response.object(forKey: "data") as! NSArray
                for item in categories {
                    self.categories?.add(JYCategory.init(dict: item as! [String : AnyObject]))
                }
                self.refreshCategories()
                self.view.setNeedsLayout()
            }
        }
    }
    
    func refreshCategories() -> Void {
        categoriesButton = NSMutableArray.init()
        
        self.categories?.insert(JYCategory(dict: ["cat_id":"0" as AnyObject, "cat_name":"全部" as AnyObject]), at: 0)
        let size = UIScreen.main.bounds.size
        let width = (size.width - 20) / 6
        var i = 0
        for item in self.categories! {
            let button = UIButton(frame: CGRect(x: Int(10 + CGFloat((i%6)+i/6)*width), y: 36 * (i/6) + 8, width: 65, height: 36))
            button.setTitle((item as! JYCategory).cat_name, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            if i == 0 {
                button.layer.cornerRadius = 18
                button.layer.masksToBounds = true
                button.layer.borderWidth = 1.0
                button.layer.borderColor = UIColor.NavigationColor().cgColor
                button.setTitleColor(UIColor.NavigationColor(), for: .normal)
            }else{
                button.setTitleColor(UIColor.titleColor_lightDark(), for: .normal)
            }
            button.tag = i
            button.addTarget(self, action: #selector(self.selectCategory(sender:)), for: .touchUpInside)
            categoriesBackground.addSubview(button)
            categoriesButton.add(button)
            i+=1
            categoriesButtonsBackgroundHeightConstraint.constant = button.frame.origin.y + button.bounds.size.height + 8
        }
        tableviewHeightConstraint.constant = size.height - UIApplication.shared.statusBarFrame.size.height - 64 - categoriesButtonsBackgroundHeightConstraint.constant - (DeviceManager.isIphoneX() ?20:0) - 80 + (onlyRank ? 12 : 0)
    }
    
    @objc func selectCategory(sender:UIButton) -> Void {
        for item in categoriesButton {
            let button:UIButton = item as! UIButton
            if sender.isEqual(button){
                button.layer.cornerRadius = 18
                button.layer.masksToBounds = true
                button.layer.borderWidth = 1.0
                button.layer.borderColor = UIColor.NavigationColor().cgColor
                button.setTitleColor(UIColor.NavigationColor(), for: .normal)
            }else{
                button.layer.cornerRadius = 0
                button.layer.masksToBounds = true
                button.layer.borderWidth = 0
                button.layer.borderColor = UIColor.clear.cgColor
                button.setTitleColor(UIColor.titleColor_lightDark(), for: .normal)
            }
        }
        
        if sender.tag == 0 {
            cat_id = ""
        }else{
            let category:JYCategory = categories?.object(at: sender.tag - 1) as! JYCategory
            cat_id = category.cat_id!
        }
        page = 1
        isConditionChange = true
        loadEnable = true
        search()
        
        print(sender.tag)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func allList(_ sender: UIButton) {
        selectButton(sender: sender, type: .serial)
        
        finish_status = ""
        search()
    }
    
    @IBAction func serialList(_ sender: UIButton) {
        selectButton(sender: sender, type: .serial)
        
        finish_status = "0"
        search()
    }
    
    @IBAction func finishList(_ sender: UIButton) {
        selectButton(sender: sender, type: .serial)
        
        finish_status = "1"
        search()
    }
    
    @IBAction func allRank(_ sender: UIButton) {
        selectButton(sender: sender, type: .rank)
        
        sort = ""
        search()
    }
    
    @IBAction func clickRank(_ sender: UIButton) {
        selectButton(sender: sender, type: .rank)
        
        sort = "hot"
        search()
    }
    
    @IBAction func payRank(_ sender: UIButton) {
        selectButton(sender: sender, type: .rank)
        
        sort = "order_count"
        search()
    }
    
    @IBAction func collectRank(_ sender: UIButton) {
        selectButton(sender: sender, type: .rank)
        
        sort = "collection_count"
        search()
    }
    
    func selectButton(sender:UIButton, type:JYButtonType) -> Void {
        for item in (type==JYButtonType.serial ? bookSerialButtons:rankButtons) {
            let button:UIButton = item as UIButton
            if button.isEqual(sender){
                button.layer.cornerRadius = 18
                button.layer.masksToBounds = true
                button.layer.borderWidth = 1.0
                button.layer.borderColor = UIColor.NavigationColor().cgColor
                button.setTitleColor(UIColor.NavigationColor(), for: .normal)
                button.isSelected = true
            }else{
                button.layer.cornerRadius = 0
                button.layer.masksToBounds = true
                button.layer.borderWidth = 0
                button.layer.borderColor = UIColor.clear.cgColor
                button.setTitleColor(UIColor.titleColor_lightDark(), for: .normal)
                button.isSelected = false
            }
        }
        page = 1
        loadEnable = true
        isConditionChange = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.books?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "JYCoverCell"
        let cell:JYCoverCell! = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? JYCoverCell
        cell.book = self.books?.object(at: indexPath.row) as! JYBanner
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = BookDetailController.create()
        let banner:JYBanner = (self.books?.object(at: indexPath.row) as? JYBanner)!
        detail.id = banner.id
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = self.tableview.contentOffset.y - (self.tableview.contentSize.height - self.tableview.bounds.size.height)
        if offset >= 0 && self.loadEnable!{
            self.page+=1
            self.search()
        }
    }
    
    @IBAction func textfieldValueChanged(_ sender: UITextField) {
        key = sender.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if key.count > 0 {
            isConditionChange = true
            search()
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
