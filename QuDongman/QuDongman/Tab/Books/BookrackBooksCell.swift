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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
