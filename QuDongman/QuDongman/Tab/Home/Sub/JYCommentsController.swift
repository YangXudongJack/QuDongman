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
    var page:Int?
    var comments:NSMutableArray?
    
    var tableview:UITableView?
    var commentInputView:JYCommentEditView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        HttpUnit.HttpGet(url: JYUrl.comments(page: page!, bookId: bookId!, chapter: chapterId!, pid: pid!)) { (response, success) in
            let comments:AnyObject = response.object(forKey: "data") as AnyObject
            if comments.isKind(of: NSArray.self) {
                let commentsArr:NSArray = comments as! NSArray
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment:JYComment = self.comments?.object(at: indexPath.row) as! JYComment
        return JYCommentCell.createCell(tableview: tableView, comment: comment, type: .list)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}





















