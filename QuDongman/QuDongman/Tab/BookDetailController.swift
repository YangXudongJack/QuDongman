//
//  BookDetailController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/7.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

enum JYBookDetailType {
    case info
    case catelog
}

class BookDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bookCoverImageview: UIImageView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var bookTagsLabel: UILabel!
    
    @IBOutlet weak var descButton: UIButton!
    
    @IBOutlet weak var catelogButton: UIButton!
    
    @IBOutlet weak var descBottomLine: UIView!
    
    @IBOutlet weak var catelogBottomLine: UIView!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var tableviewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var readNowButton: UIButton!
    
    @IBOutlet weak var readNowImage: UIImageView!
    
    @IBOutlet weak var readNowLabel: UILabel!
    
    var _type:JYBookDetailType?
    var type:JYBookDetailType? {
        set {
            let size = UIScreen.main.bounds.size
            let scale:CGFloat = size.width / 375.0
            if newValue == .info {
                readNowButton.isHidden = false
                readNowImage.isHidden = false
                readNowLabel.isHidden = false
                tableviewHeightConstraint.constant = size.height - 210 * scale - 60 - 44
            }else{
                readNowButton.isHidden = true
                readNowImage.isHidden = true
                readNowLabel.isHidden = true
                tableviewHeightConstraint.constant = size.height - 210 * scale - 60
                
                _fetchCartoonContent()
            }
            _type = newValue
        }
        
        get {
            return _type
        }
    }
    
    var banner:JYBanner?
    var cartoonContent:JYCartoonContent?
    var _bookInfo:JYCartoon?
    var bookInfo:JYCartoon?{
        set{
            bookCoverImageview.sd_setImage(with: URL.init(string: (newValue?.book_reesult?.cover_image)!), placeholderImage: UIImage.init(named: "bookCover_placeholder"), options: .retryFailed, completed: nil)
            bookTitleLabel.text = newValue?.book_reesult?.name
            
            var tags:String = String.init()
            for item in (newValue?.book_reesult?.tag_results)! {
                tags.append("#\(item)# ")
            }
            bookTagsLabel.text = tags
            _bookInfo = newValue
        }
        
        get{
            return _bookInfo
        }
    }
    
    class func create() -> BookDetailController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "BookDetailController") as! BookDetailController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideTabbar()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        type = .info
        tableview.register(UINib.init(nibName: "JYCommentCell", bundle: Bundle.main), forCellReuseIdentifier: "JYCommentCell")
        _configNav()
        _initDetailData()
    }
    
    func _configNav() -> Void {
        createNavBackBtn()
        
        let share:UIButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 32, height: 30))
        share.setImage(UIImage.init(named: "nav_share"), for: .normal)
        let shareItem:UIBarButtonItem = UIBarButtonItem.init(customView: share)
        
        let collect:UIButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 32, height: 30))
        collect.setImage(UIImage.init(named: "nav_collect"), for: .normal)
        let collectItem:UIBarButtonItem = UIBarButtonItem.init(customView: collect)
        
        self.navigationItem.rightBarButtonItems = [collectItem, shareItem]
    }
    
    func _initDetailData() -> Void {
        JYProgressHUD.show()
        HttpUnit.HttpGet(url: JYUrl.detail(id: Int((banner?.id)!)!)) { (responseObject, success) in
            if success {
                let data = responseObject.object(forKey: "data")
                self.bookInfo = JYCartoon.init(dict: data as! [String : AnyObject])
                self.tableview.reloadData()
            }
            JYProgressHUD.dismiss()
        }
    }
    
    func _fetchCartoonContent() -> Void {
        JYProgressHUD.show()
        let catelog:JYCatelog = self.bookInfo?.chapter_results?.first as! JYCatelog
        let chapter:Int = Int(catelog.id!)!
        HttpUnit.HttpGet(url: JYUrl.content(id: Int((banner?.id)!)!, chapter: chapter)) { (responseObject, success) in
            if success {
                let data = responseObject.object(forKey: "data")
                self.cartoonContent = JYCartoonContent.init(dict: data as! [String : AnyObject])
                self.tableview.reloadData()
            }
            JYProgressHUD.dismiss()
        }
    }

    @IBAction func bookDescAction(_ sender: UIButton) {
        descButton.isSelected = true
        descBottomLine.isHidden = false
        catelogButton.isSelected = false
        catelogBottomLine.isHidden = true
        type = .info
        tableview.reloadData()
    }
    
    @IBAction func bookCatelogAction(_ sender: UIButton) {
        descButton.isSelected = false
        descBottomLine.isHidden = true
        catelogButton.isSelected = true
        catelogBottomLine.isHidden = false
        type = .catelog
        tableview.reloadData()
    }
    
    @IBAction func readNowAction(_ sender: UIButton) {
        let catelog:JYCatelog = self.bookInfo?.chapter_results?.first as! JYCatelog
        let book = BookContentController.bookContent(id: (banner?.id)!, chapter: catelog.id!, title: catelog.name!)
        self.navigationController?.pushViewController(book, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .info?: do {
            return bookInfo == nil ? 0 : 3 + (self.bookInfo?.comment_results?.results?.count)!
        }
            
        default: do{
            if self.cartoonContent == nil {
                return 1
            }else{
                return 1 + (self.cartoonContent?.content_results?.count)!
            }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch type {
        case .info?: do {
            switch indexPath.row {
            case 0: do {
                return 106.0
                }
                
            case 1: do {
                return 47.0
                }
                
            case 2 + (self.bookInfo?.comment_results?.results?.count)!: do {
                return 21.0
                }
                
            default:
                return 99.0
            }
        }
            
        default: do {
            switch indexPath.row {
                case 0:do{
                    return 108.0
                }
                
                default:do{
                    let screenWidth = UIScreen.main.bounds.size.width
                    let scale = screenWidth / 320.0
                    return 427 * scale
                }
            }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .info?: do {
            switch indexPath.row {
            case 0: do {
                let cell = JYBookDescCell.createCell(tableview: tableView)
                cell.desc = (bookInfo?.book_reesult?.descp)!
                return cell
                }
                
            case 1: do {
                let cell = JYCommentsHeaderCell.createCell(tableview: tableView)
                cell.count = (self.bookInfo?.comment_results?.count)!
                return cell
                }
                
            case 2 + (self.bookInfo?.comment_results?.results?.count)!: do {
                return JYAllCommentsEntranceCell.createCell(tableview: tableView)
                }
                
            default: do {
                let identifier = "JYCommentCell"
                let cell:JYCommentCell! = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? JYCommentCell
                cell.comment = self.bookInfo?.comment_results?.results?.object(at: indexPath.row - 2) as! JYComment
                return cell
                }
            }
        }
            
        default: do {
            switch indexPath.row {
                case 0:do{
                    let cell:JYCatelogCell = JYCatelogCell.createCell(tableview: tableview, colsure: { (catelog, actionType) in
                        switch actionType {
                        case .catelog: do {
                            let book = BookContentController.bookContent(id: (self.banner?.id)!, chapter: catelog.id!, title: catelog.name!)
                            self.navigationController?.pushViewController(book, animated: true)
                            }
                            
                        default : do {
                            JYAllCatelogView.showAllCatelog(catelogs: (self.bookInfo?.chapter_results)!, colsure: { (catelog) in
                                
                            })
                            }
                        }
                    })
                    cell.catelogs = self.bookInfo?.chapter_results! as! NSArray
                    return cell
                }
                
                default:do{
                    let cell = CartoonContentCell.createCell(tableview: tableView)
                    cell.imageName = self.cartoonContent?.content_results![indexPath.row - 1] as! String
                    return cell
                }
            }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}















