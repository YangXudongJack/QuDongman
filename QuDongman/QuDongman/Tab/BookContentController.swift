//
//  BookContentController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit
import Alamofire

class BookContentController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var id:String?
    var chapter:String?
    var cartoonTitle:String?
    
    var autoBack:Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var cartoonContent:JYCartoonContent?
    
    @IBOutlet weak var collectButton: UIButton!
    @IBOutlet weak var titleBackViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputBottomWithToolBarConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sendCommentBtn: UIButton!
    @IBOutlet var toolbar: [UIView]!
    @IBOutlet weak var topToolBar: UIView!
    
    @IBOutlet weak var bottomToolBarHeightConstraint: NSLayoutConstraint!
    var didScroll:Bool?
    
    var beginPoint:CGPoint?
    var endPoint:CGPoint?
    
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var chapterNameLabel: UILabel!
    
    var indexPathList:NSMutableArray?
    
    class func bookContent(id:String, chapter:String, title:String) -> BookContentController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let book = storyboard.instantiateViewController(withIdentifier: "BookContentController") as! BookContentController
        book.id = id
        book.chapter = chapter
        book.cartoonTitle = title
        return book
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        hideTabbar()
        _fetchData()
        
        if autoBack {
            topToolBar.isHidden = true
            bottomToolBarHeightConstraint.constant = 0
            collectButton.isHidden = true
        }
        
        tableview.scrollsToTop = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexPathList = NSMutableArray()
        didScroll = false
        titleLabel.text = cartoonTitle
        chapterNameLabel.text = cartoonTitle
        if DeviceManager.isIphoneX() {
            titleBackViewHeightConstraint.constant = 88
        }
        for view in toolbar {
            view.backgroundColor = UIColor.boardColor().withAlphaComponent(0.9)
        }
        collectButton.backgroundColor = UIColor.boardColor().withAlphaComponent(0.5)
        HttpUnit.addHistory(id: id!, chapter: chapter!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let pan:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(calculateGesture(_:)))
        self.view.addGestureRecognizer(pan)
    }
    
    func _fetchData() -> Void {
        JYProgressHUD.show()
        HttpUnit.HttpGet(url: JYUrl.content(id: Int(id!)!, chapter: Int(chapter!)!)) { (responseObject, success) in
            if success {
                let data = responseObject.object(forKey: "data")
                self.cartoonContent = JYCartoonContent.init(dict: data as! [String : AnyObject])
                if Int((self.cartoonContent?.is_buy)!)! == 1 {
                    self.titleLabel.text = self.cartoonContent?.pay_data?.title
                    self.chapterNameLabel.text = self.cartoonContent?.pay_data?.title
                    self.tableview?.reloadData()
                }else{
                    let buy:JYChapterBuyController = JYChapterBuyController.showChapterBuyView(title: (self.cartoonContent?.pay_data?.title)!, price: (self.cartoonContent?.pay_data?.fee)!, balance: (self.cartoonContent?.pay_data?.balance)!, colsure: {
                        self.navigationController?.popViewController(animated: true)
                    })
                    buy.bookId = self.id
                    buy.chapterId = self.chapter
                    self.present(buy, animated: true, completion: nil)
                    
                }
            }
            JYProgressHUD.dismiss()
        }
    }
    
    @IBAction func addCollection(_ sender: UIButton) {
        HttpUnit.addCollection(id: id!)
    }
    
    @IBAction func addComment(_ sender: UIButton) {
        JYProgressHUD.show()
        
        var params:Parameters = Parameters.init()
        params["to_member_id"] = "0"
        params["book_id"] = id
        params["chapter_id"] = chapter
        params["content"] = commentTF.text
        params["pid"] = "0"
        HttpUnit.HttpPost(url: JYUrl.addComments(), params: params) { (response, success) in
            if success {
                let result:String = response.object(forKey: "code") as! String
                if Int(result) == 1 {
                    self.commentTF.text = nil
                    self.view.endEditing(true)
                }
            }
            JYProgressHUD.dismiss()
        }
    }
    
    @IBAction func prev_chapter(_ sender: UIButton) {
        self.chapter = self.cartoonContent?.prev_chapter_id
        self._fetchData()
    }
    
    @IBAction func next_chapter(_ sender: UIButton) {
        self.chapter = self.cartoonContent?.next_chapter_id
        self._fetchData()
    }
    
    @IBAction func commentEdit(_ sender: UIButton) {
        let comments:JYCommentsController = JYCommentsController()
        comments.bookId = self.id
        comments.chapterId = self.chapter
        comments.pid = "0"
        self.navigationController?.pushViewController(comments, animated: true)
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
    
    @objc func keyboardWillShow(_ notification : Notification) -> Void {
        weak var weakSelf = self
        let kbInfo = notification.userInfo
        let kbRect = (kbInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let changeY = kbRect.origin.y - UIScreen.main.bounds.size.height
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as!Double
        UIView.animate(withDuration: duration) {
            weakSelf?.inputBottomWithToolBarConstraint.constant = changeY * (changeY > 0 ? 1 : -1) - 44
        }
    }
    
    @objc func keyboardWillHide(_ notification : Notification) -> Void {
        weak var weakSelf = self
        let kbInfo = notification.userInfo
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as!Double
        UIView.animate(withDuration: duration) {
            weakSelf?.inputBottomWithToolBarConstraint.constant = 0
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self._fetchCellHeight(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartoonContent == nil {
            return 0
        }else{
            return (cartoonContent?.content_results?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CartoonContentCell.createCell(tableview: tableView, indexPath: indexPath) { (height) in
            let cellInfo = JYCellInfo()
            cellInfo.indexPath = indexPath
            cellInfo.height = height
            self._updateCellHeight(cellInfo: cellInfo)
            tableView.reloadData()
        }
        cell.imageName = self.cartoonContent?.content_results![indexPath.row] as! String
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        didScroll = true
        for view in toolbar {
            if autoBack {
                if view == topToolBar {
                    continue
                }else{
                    UIView.animate(withDuration: 0.5) {
                        view.alpha = 1
                    }
                }
            }else{
                UIView.animate(withDuration: 0.5) {
                    view.alpha = 1
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if autoBack && tableview.contentOffset.y < -20{
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        if didScroll! {
            for view in toolbar {
                if autoBack {
                    if view == topToolBar {
                        continue
                    }else{
                        UIView.animate(withDuration: 0.5) {
                            view.alpha = 1
                        }
                    }
                }else{
                    UIView.animate(withDuration: 0.5) {
                        view.alpha = 1
                    }
                }
            }
        }
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        didScroll = true
        for view in toolbar {
            if autoBack {
                if view == topToolBar {
                    continue
                }else{
                    UIView.animate(withDuration: 0.5) {
                        view.alpha = 1
                    }
                }
            }else{
                UIView.animate(withDuration: 0.5) {
                    view.alpha = 1
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let rag = textField.text?.toRange(range)
        let string = textField.text?.replacingCharacters(in: rag!, with: string)
        if (string?.characters.count)! > 0 {
            sendCommentBtn.isEnabled = true
        }else{
            sendCommentBtn.isEnabled = false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func calculateGesture(_ pan:UIPanGestureRecognizer) -> Void {
        if pan.state == .began {
            beginPoint = pan.translation(in: self.tableview)
        }else if pan.state == .ended {
            endPoint = pan.translation(in: self.tableview)
            
            var yOffset:CGFloat = (beginPoint?.y)! - (endPoint?.y)!
            if yOffset < 0 {
                yOffset = yOffset * -1
            }
            
            if (beginPoint?.x)! - (endPoint?.x)! > 30 && yOffset < 30{
                if self.cartoonContent?.next_chapter_id != self.chapter {
                    self.autoBack = false
                    self.topToolBar.isHidden = false
                    self.bottomToolBarHeightConstraint.constant = 44
                    self.chapter = self.cartoonContent?.next_chapter_id
                    self._fetchData()
                }
            }else if (beginPoint?.x)! - (endPoint?.x)! < -30 && yOffset < 30{
                if self.cartoonContent?.prev_chapter_id != self.chapter {
                    self.autoBack = false
                    self.topToolBar.isHidden = false
                    self.bottomToolBarHeightConstraint.constant = 44
                    self.chapter = self.cartoonContent?.prev_chapter_id
                    self._fetchData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
