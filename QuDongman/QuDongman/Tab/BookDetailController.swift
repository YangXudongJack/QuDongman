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

class JYCellInfo: JYBaseObject {
    var indexPath:IndexPath?
    var height:CGFloat?
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
    
//    @IBOutlet weak var readNowButton: UIButton!
    
//    @IBOutlet weak var readNowImage: UIImageView!
//    
//    @IBOutlet weak var readNowLabel: UILabel!
    
    var indexPathList:NSMutableArray?
    
    var _type:JYBookDetailType?
    var type:JYBookDetailType? {
        set {
            let size = UIScreen.main.bounds.size
            let scale:CGFloat = size.width / 375.0
            if newValue == .info {
//                readNowButton.isHidden = false
//                readNowImage.isHidden = false
//                readNowLabel.isHidden = false
            }else{
//                readNowButton.isHidden = true
//                readNowImage.isHidden = true
//                readNowLabel.isHidden = true
                
                _fetchCartoonContent()
            }
            tableviewHeightConstraint.constant = size.height - 210 * scale - 60
            _type = newValue
        }
        
        get {
            return _type
        }
    }
    
    var id:String?
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
        indexPathList = NSMutableArray()
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
        HttpUnit.HttpGet(url: JYUrl.detail(id: Int(self.id!)!)) { (responseObject, success) in
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
        HttpUnit.HttpGet(url: JYUrl.content(id: Int(self.id!)!, chapter: chapter)) { (responseObject, success) in
            if success {
                let data = responseObject.object(forKey: "data")
                self.cartoonContent = JYCartoonContent.init(dict: data as! [String : AnyObject])
                self.tableview.reloadData()
            }
            JYProgressHUD.dismiss()
        }
    }
    
    func _fetchCellHeight(indexPath:IndexPath) -> CGFloat {
        for item in self.indexPathList! {
            let cellInfo:JYCellInfo = item as! JYCellInfo
            if cellInfo.indexPath?.section == indexPath.section &&
                cellInfo.indexPath?.row == indexPath.row {
                return cellInfo.height!
            }
        }
        
        let screenWidth = UIScreen.main.bounds.size.width
        let scale = screenWidth / 375.0
        return 214.0 * scale
    }
    
    func _updateCellHeight(cellInfo:JYCellInfo) -> Void {
        for item in self.indexPathList! {
            let info:JYCellInfo = item as! JYCellInfo
            if cellInfo.indexPath?.section == info.indexPath?.section &&
                cellInfo.indexPath?.row == info.indexPath?.row {
                info.height = cellInfo.height
                return
            }
        }
        
        self.indexPathList?.add(cellInfo)
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
        let book = BookContentController.bookContent(id: self.id!, chapter: catelog.id!, title: catelog.name!)
        self.navigationController?.pushViewController(book, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .info?: do {
            return bookInfo == nil ? 0 : 4 + (self.bookInfo?.comment_results?.results?.count)!
        }
            
        default: do{
//            if self.cartoonContent == nil {
//                return 1
//            }else{
//                return 1 + (self.cartoonContent?.content_results?.count)!
//            }
            return 1
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
                
            case 3 + (self.bookInfo?.comment_results?.results?.count)!: do {
                return 44.0
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
                    return self._fetchCellHeight(indexPath: indexPath)
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
                return JYAllCommentsEntranceCell.createCell(tableview: tableView, colsure: {
                    let comments:JYCommentsController = JYCommentsController()
                    let catelog:JYCatelog = self.bookInfo?.chapter_results?.first as! JYCatelog
                    let chapter:Int = Int(catelog.id!)!
                    comments.bookId = self.id
                    comments.chapterId = catelog.id
                    comments.pid = "0"
                    self.navigationController?.pushViewController(comments, animated: true)
                })
                }
                
            case 3 + (self.bookInfo?.comment_results?.results?.count)!: do {
                return JYReadNowCell.createCell(tableview: tableView, colsure: {
                    let catelog:JYCatelog = self.bookInfo?.chapter_results?.first as! JYCatelog
                    let book = BookContentController.bookContent(id: self.id!, chapter: catelog.id!, title: catelog.name!)
                    book.autoBack = true
                    self.navigationController?.pushViewController(book, animated: false)
                })
                }
                
            default: do {
                let comment:JYComment = self.bookInfo?.comment_results?.results?.object(at: indexPath.row - 2) as! JYComment
                return JYCommentCell.createCell(tableview: tableView, comment: comment, type: .filter, colsure: {
                    let comments:JYCommentsController = JYCommentsController()
                    let catelog:JYCatelog = self.bookInfo?.chapter_results?.first as! JYCatelog
                    let chapter:Int = Int(catelog.id!)!
                    comments.bookId = self.id
                    comments.chapterId = catelog.id
                    comments.pid = "0"
                    self.navigationController?.pushViewController(comments, animated: true)
                })
                }
            }
        }
            
        default: do {
            switch indexPath.row {
                case 0:do{
                    let cell:JYCatelogCell = JYCatelogCell.createCell(tableview: tableview, colsure: { (catelog, actionType) in
                        switch actionType {
                        case .catelog: do {
                            let book = BookContentController.bookContent(id: self.id!, chapter: catelog.id!, title: catelog.name!)
                            self.navigationController?.pushViewController(book, animated: true)
                            }
                            
                        default : do {
                            JYAllCatelogView.showAllCatelog(catelogs: (self.bookInfo?.chapter_results)!, colsure: { (catelog) in
                                let book = BookContentController.bookContent(id: self.id!, chapter: catelog.id!, title: catelog.name!)
                                self.navigationController?.pushViewController(book, animated: true)
                            })
                            }
                        }
                    })
                    cell.catelogs = self.bookInfo?.chapter_results! as! NSArray
                    return cell
                }
                
                default:do{
                    let cell = CartoonContentCell.createCell(tableview: tableView, indexPath: indexPath) { (height) in
                        let cellInfo = JYCellInfo()
                        cellInfo.indexPath = indexPath
                        cellInfo.height = height
                        self._updateCellHeight(cellInfo: cellInfo)
                        tableView.reloadData()
                    }
                    cell.imageName = self.cartoonContent?.content_results![indexPath.row - 1] as! String
                    return cell
                }
            }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var autoRead = false
        if tableview.bounds.size.height > tableview.contentSize.height {
            autoRead = tableview.contentOffset.y > 20
        }else{
            autoRead = tableview.contentOffset.y + tableview.bounds.size.height > tableview.contentSize.height
        }
        if autoRead && type == .info {
            let catelog:JYCatelog = self.bookInfo?.chapter_results?.first as! JYCatelog
            let book = BookContentController.bookContent(id: self.id!, chapter: catelog.id!, title: catelog.name!)
            book.autoBack = true
            self.navigationController?.pushViewController(book, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}















