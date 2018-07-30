//
//  JYListCommentCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/28.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYListCommentCell: JYBaseCell {
    
    var height:CGFloat?
    
    var _comment:JYComment?
    var comment:JYComment? {
        set {
            _comment = newValue
            
            headerImage.sd_setImage(with: URL(string: (newValue?.member_result?.avatar)!), placeholderImage: nil, options: .retryFailed, completed: nil)
            ownerNameLabel.text = newValue?.member_result?.nickname
            timeLabel.text = newValue?.created_at
            ownerCommentLabel.text = newValue?.content
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
    
    var commentColsure:(()->Void)?
    
    class func createCell(tableview: UITableView,
                          comments:JYComment,
                          colsure:@escaping ()->Void) -> JYListCommentCell{
        let identifier = "JYListCommentCell"
        var cell:JYListCommentCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYListCommentCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("JYListCommentCell",
                                            owner: nil,
                                            options: nil)?.first as! JYListCommentCell
        }
        cell.comment = comments
        cell.commentColsure = colsure
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func replayOwner(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func replayFirst(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func replaySecond(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func openAllReplay(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}













