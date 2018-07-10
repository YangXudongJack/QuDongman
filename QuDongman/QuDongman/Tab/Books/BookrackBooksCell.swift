//
//  BookrackBooksCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/5/27.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class BookrackBooksCell: UICollectionViewCell {

    static let identifier = "BookrackBooksCell"
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    
    var _collect:JYCollection?
    var collect:JYCollection? {
        set {
            bookCover.sd_setImage(with: URL(string: (newValue?.cover_image)!), placeholderImage: UIImage.init(named: "bookrack"), options: .retryFailed, completed: nil)
            bookTitle.text = newValue?.name
            _collect = newValue
        }
        
        get {
            return _collect
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
