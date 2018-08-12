//
//  JYCommentsController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/26.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYCommentsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var bookId:String?
    var chapterId:String?
    var pid:String?
    var page:Int = 1
    var comments:NSMutableArray?
    var type:CommentType = .main
    var defaultComment:JYComment?
    var loadEnable:Bool = true
    
    var tableview:UITableView?
    var commentInputView:JYCommentEditView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        
        let nav:JYNavigationController = self.navigationController as! JYNavigationController
        nav.changeConfig()
        self.title = "评论"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createNavBackBtn_Yello()
        self.view.backgroundColor = UIColor.white
        
        page = 1
        comments = NSMutableArray()
        if type == .sub {
            comments?.add(defaultComment)
        }
        initSubview()
        initComments()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func initSubview() -> Void {
        let size = self.view.bounds
        let statusbarHeight = UIApplication.shared.statusBarFrame.size.height
        let navHeight = self.navigationController?.navigationBar.bounds.size.height
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height - statusbarHeight - navHeight! - 56), style: .plain)
        tableview?.showsVerticalScrollIndicator = false
        tableview?.delegate = self
        tableview?.dataSource = self
        tableview?.separatorStyle = .none
        tableview?.backgroundColor = UIColor.AboutBackgroundColor()
        tableview?.estimatedRowHeight = 99
        tableview?.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableview!)
        
        commentInputView = JYCommentEditView.showAddCommentView(frame: CGRect(x: 0, y: (tableview?.frame.origin.y)! + (tableview?.frame.size.height)!, width: size.width, height: 56), colsure: {
            self.comments?.removeAllObjects()
            self.initComments()
        })
        commentInputView?.bookId = bookId
        commentInputView?.chapterId = chapterId
        commentInputView?.pid = pid
        commentInputView?.to_member_id = "0"
        self.view.addSubview(commentInputView!)
    }
    
    func initComments() -> Void {
        JYProgressHUD.show()
        HttpUnit.HttpGet(url: JYUrl.comments(page: page, bookId: bookId!, chapter: chapterId!, pid: pid!)) { (response, success) in
            let comments:AnyObject = response.object(forKey: "data") as AnyObject
            if comments.isKind(of: NSArray.self) {
                let commentsArr:NSArray = comments as! NSArray
                if commentsArr.count < 4 {
                    self.loadEnable = false
                }
                for item in commentsArr {
                    let comment:JYComment = JYComment(dict: item as! [String : AnyObject])
                    self.comments?.add(comment)
                }
                
                self.tableview?.reloadData()
            }
            JYProgressHUD.dismiss()
        }
    }
    
    @objc func keyboardWillShow(_ notification : Notification) -> Void {
        weak var weakSelf = self
        let size = self.view.bounds
        
        let kbInfo = notification.userInfo
        let kbRect = (kbInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as!Double
        UIView.animate(withDuration: duration) {
            weakSelf?.tableview?.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - 56 - kbRect.size.height)
            weakSelf?.commentInputView?.frame = CGRect(x: 0, y: (weakSelf?.tableview?.frame.origin.y)! + (weakSelf?.tableview?.frame.size.height)!, width: size.width, height: 56)
            weakSelf?.tableview?.setContentOffset(CGPoint(x: 0, y: ((weakSelf?.tableview?.contentSize.height)! - (weakSelf?.tableview?.bounds.size.height)!)), animated: true)
        }
    }
    
    @objc func keyboardWillHide(_ notification : Notification) -> Void {
        weak var weakSelf = self
        let size = self.view.bounds
        
        let kbInfo = notification.userInfo
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as!Double
        UIView.animate(withDuration: duration) {
            weakSelf?.tableview?.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - 56)
            weakSelf?.commentInputView?.frame = CGRect(x: 0, y: (weakSelf?.tableview?.frame.origin.y)! + (weakSelf?.tableview?.frame.size.height)!, width: size.width, height: 56)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.comments?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment:JYComment = self.comments?.object(at: indexPath.row) as! JYComment
        return JYListCommentCell.createCell(tableview: tableView, comments: comment, bookId: bookId!, chapter: chapterId!, type:type, colsure: { (commentObj) in
            self.commentInputView?.commentTextField.becomeFirstResponder()
            let defaultHeader:String = (commentObj.member_result?.nickname)!
            self.commentInputView?.defaultString = "回复\(defaultHeader):"
            self.commentInputView?.pid = commentObj.id
        }, allCommentsColsure: { (commentObj) in
            let comments:JYCommentsController = JYCommentsController()
            comments.bookId = self.bookId
            comments.chapterId = self.chapterId
            comments.pid = commentObj.id
            comments.type = .sub
            comments.defaultComment = commentObj;
            self.navigationController?.pushViewController(comments, animated: true)
        })
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = (self.tableview?.contentOffset.y)! - ((self.tableview?.contentSize.height)! - (self.tableview?.bounds.size.height)!)
        if offset >= 0 && self.loadEnable{
            page+=1
            initComments()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}





















