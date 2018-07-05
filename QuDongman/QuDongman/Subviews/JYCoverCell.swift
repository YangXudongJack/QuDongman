//
//  JYCoverCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/6/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYCoverCell: JYBaseCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var topIcon: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var _book:JYBanner?
    var book:JYBanner {
        set {
            coverImage.sd_setImage(with: URL.init(string: newValue.banner_image!),
                                   placeholderImage: UIImage.init(named: "bookCover_placeholder"),
                                   options: .retryFailed, completed: nil)
            bookNameLabel.text = newValue.name
            numberLabel.text = newValue.hot
            
            _book = newValue
        }
        
        get {
            return _book!
        }
    }
    
    var _index:Int?
    var index:Int {
        set {
            switch newValue {
            case 0: do {
                topIcon.isHidden = false
                topIcon.image = UIImage.init(named: "top_1")
                }
                
            case 1: do{
                topIcon.isHidden = false
                topIcon.image = UIImage.init(named: "top_2")
                }
                
            case 2: do{
                topIcon.isHidden = false
                topIcon.image = UIImage.init(named: "top_3")
                }
                
            default:
                topIcon.isHidden = true
            }
            
            _index = newValue
        }
        
        get {
            return _index!
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
