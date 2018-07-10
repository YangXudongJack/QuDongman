//
//  JYCommentCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/7.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYCommentCell: JYBaseCell {

    @IBOutlet weak var comment_user_header: UIImageView!
    
    @IBOutlet weak var comment_user_name: UILabel!
    
    @IBOutlet weak var comment_user_time: UILabel!
    
    @IBOutlet weak var comment_user_comment: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    var _comment:JYComment?
    var comment:JYComment {
        set {
            comment_user_header.sd_setImage(with: URL(string: (newValue.member_result?.avatar)!), placeholderImage: nil, options: .retryFailed, completed: nil)
            comment_user_name.text = newValue.member_result?.nickname
            comment_user_time.text = newValue.created_at
            comment_user_comment.text = newValue.content
            
            _comment = newValue
        }
        
        get {
            return _comment!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        comment_user_header.layer.cornerRadius = 16.0
        comment_user_header.layer.masksToBounds = true
    }
    
    @IBAction func commentAction(_ sender: UIButton) {
        
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
