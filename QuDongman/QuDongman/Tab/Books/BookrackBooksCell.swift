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
    
    var collectionColsure:((JYCollection)->Void)?
    
    class func createCell(collectionView: UICollectionView,
                          indexPath:IndexPath,
                          collect:JYCollection,
                          colsure:@escaping (JYCollection)->Void) -> BookrackBooksCell{
        var cell:BookrackBooksCell! = collectionView.dequeueReusableCell(withReuseIdentifier: BookrackBooksCell.identifier, for: indexPath) as? BookrackBooksCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("BookrackBooksCell",
                                            owner: nil,
                                            options: nil)?.first as! BookrackBooksCell
        }
        cell.collect = collect
        cell.collectionColsure = colsure
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectThisCollect(_:)))
        self.contentView.addGestureRecognizer(tap)
    }
    
    @objc func selectThisCollect(_ tap:UITapGestureRecognizer) {
        self.collectionColsure!(self.collect!)
    }

}












