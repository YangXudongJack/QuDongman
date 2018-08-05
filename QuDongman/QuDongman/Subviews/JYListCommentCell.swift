//
//  JYListCommentCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/28.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYListCommentCell: JYBaseCell {
    
    var bookId:String?
    var chapter:String?
    
    var _comment:JYComment?
    var comment:JYComment? {
        set {
            _comment = newValue
            
            headerImage.sd_setImage(with: URL(string: (newValue?.member_result?.avatar)!), placeholderImage: UIImage(named: "icon_portrait"), options: .retryFailed, completed: nil)
            ownerNameLabel.text = newValue?.member_result?.nickname
            timeLabel.text = newValue?.created_at
            ownerCommentLabel.text = newValue?.content
            
            if Int((newValue?.comment_count)!)! == 0 {
                firstCommentLabel.text = nil
                secondCommentLabel.text = nil
                cellBottomWithReplyBottomConstraint.constant = -43
            }else{
                if Int((newValue?.comment_count)!)! == 1 {
                    secondCommentLabel.text = nil
                }
                self.initComments()
            }
        }
        
        get {
            return _comment
        }
    }

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ownerCommentLabel: UILabel!
    @IBOutlet weak var firstCommentLabel: UILabel!
    @IBOutlet weak var secondCommentLabel: UILabel!
    @IBOutlet weak var spreadButtonWithSecondCommentConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellBottomWithReplyBottomConstraint: NSLayoutConstraint!
    
    var commentColsure:((JYComment)->Void)?
    
    class func createCell(tableview: UITableView,
                          comments:JYComment,
                          bookId:String,
                          chapter:String,
                          colsure:@escaping (JYComment)->Void) -> JYListCommentCell{
        let identifier = "JYListCommentCell"
        var cell:JYListCommentCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYListCommentCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("JYListCommentCell",
                                            owner: nil,
                                            options: nil)?.first as! JYListCommentCell
        }
        cell.bookId = bookId
        cell.chapter = chapter
        cell.comment = comments
        cell.commentColsure = colsure
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerImage.layer.cornerRadius = 16.0
        headerImage.layer.masksToBounds = true
    }
    
    func initComments() -> Void {
        JYProgressHUD.show()
        HttpUnit.HttpGet(url: JYUrl.comments(page: 1, bookId: bookId!, chapter: chapter!, pid: (self.comment?.id!)!)) { (response, success) in
            let comments:AnyObject = response.object(forKey: "data") as AnyObject
            if comments.isKind(of: NSArray.self) {
                let commentsArr:NSArray = comments as! NSArray
                var index = 0
                for item in commentsArr {
                    let comment:JYComment = JYComment(dict: item as! [String : AnyObject])
                    if index == 0 {
                        self.firstCommentLabel.attributedText = self._changeColor(string: "\(comment.member_result!.nickname!):\(comment.content!)" as NSString, colorString: "\(comment.content!)")
                    }
                    if index == 1 {
                        self.secondCommentLabel.attributedText = self._changeColor(string: "\(comment.member_result!.nickname!):\(comment.content!)" as NSString, colorString: "\(comment.content!)")
                    }
                    index = index + 1
                }
            }
            JYProgressHUD.dismiss()
        }
    }

    @IBAction func replayOwner(_ sender: UITapGestureRecognizer) {
        if (commentColsure != nil) {
            self.commentColsure!(self.comment!)
        }
    }
    
    @IBAction func replayFirst(_ sender: UITapGestureRecognizer) {
        if (commentColsure != nil) {
            self.commentColsure!(self.comment!)
        }
    }
    
    @IBAction func replaySecond(_ sender: UITapGestureRecognizer) {
        if (commentColsure != nil) {
            self.commentColsure!(self.comment!)
        }
    }
    
    @IBAction func openAllReplay(_ sender: UIButton) {
    }
    
    func _changeColor(string:NSString, colorString:String) -> NSAttributedString {
        let attributestring = NSMutableAttributedString(string: string as String)
        let range:NSRange = string.range(of: colorString)
        let colorDic = [NSAttributedStringKey.foregroundColor : UIColor.normalPriceInfo()]
        attributestring.addAttributes(colorDic, range: range)
        return attributestring
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}













