//
//  CartoonCoverCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/15.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import UIKit

typealias ReadColsure = ()->Void

class CartoonCoverCell: JYBaseCell {
    
    static let identifier = "CartoonCoverCell"
    
    var coverImage : UIImageView?;
    var titleLabel : UILabel?;
    var tagLabel : UILabel?;
    var readButton : UIButton?;
    var descTitleLabel : UILabel?
    var descriptionLabel : UILabel?
    var activityIndicator : UIActivityIndicatorView?
    
    var readColsure : ReadColsure?
    
    var gradientLayer: CAGradientLayer!
    
    var info:JYCartoon? {
        set {
            let queue = DispatchQueue(label: "load.image")
            queue.async {
                let imageName = newValue?.book_reesult?.cover_image
                if (imageName)?.isEmpty == false {
                    let url = URL.init(string: imageName!)!
                    do {
                        let data : NSData = try NSData(contentsOf: url)
                        DispatchQueue.main.async {
                            self.coverImage?.image = UIImage(data: data as Data)
                            self.activityIndicator?.stopAnimating()
                        }
                    } catch {}
                }
            }
            
            let title = newValue?.book_reesult?.name
            self.titleLabel?.text = title
            
            var count:Int = 0
            let tag_results:NSMutableString = NSMutableString.init()
            let issuer:String = (newValue?.book_reesult?.issuer)!
            tag_results.append("出品方：\(issuer)\n")
            for item in (newValue?.book_reesult?.tag_results)! {
                if count == 0 {
                    tag_results.append("标签：\(item)")
                }else{
                    tag_results.append("、\(item)")
                }
                count+=1
            }
            let mastring = NSMutableAttributedString.init(string: tag_results as String)
            let mpstyle = NSMutableParagraphStyle.init()
            mpstyle.lineSpacing = 4.0
            mastring.addAttribute(.paragraphStyle, value: mpstyle, range: NSMakeRange(0, mastring.length))
            self.tagLabel?.attributedText = mastring
            
            let screenWidth = UIScreen.main.bounds.size.width
            let detail : NSString = newValue?.book_reesult?.descp as! NSString
            let defaultSize = CGSize(width: UIScreen.main.bounds.size.width - 24, height: 300)
            let dic = NSDictionary(object: UIFont.systemFont(ofSize: 16), forKey: NSAttributedStringKey.font as NSCopying)
            let size = detail.boundingRect(with: defaultSize, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any] , context: nil)
            self.descriptionLabel?.frame = CGRect(x: (self.descriptionLabel?.frame.origin.x)!, y: (self.descriptionLabel?.frame.origin.y)!, width: (self.descriptionLabel?.bounds.size.width)!, height: size.height)
            self.descriptionLabel?.text = detail as String
            self.contentView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (self.descriptionLabel?.frame.origin.y)! + (self.descriptionLabel?.bounds.size.height)!)
        }
        
        get {
            return nil
        }
    }
    
    
    class func createCell(tableview: UITableView) -> CartoonCoverCell {
        var cell:CartoonCoverCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? CartoonCoverCell
        if cell == nil {
            cell = CartoonCoverCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let scale = screenWidth / 320.0
        coverImage = UIImageView(frame: CGRect(x: 12, y: 4, width: 200 * scale, height: 266 * scale))
        coverImage?.image = UIImage.init()
        self.contentView.addSubview(coverImage!)
        
        titleLabel = UILabel(frame: CGRect(x: (coverImage?.frame.origin.x)! + (coverImage?.bounds.size.width)! + 7, y: (coverImage?.frame.origin.y)!, width: screenWidth - (coverImage?.frame.origin.x)! - (coverImage?.bounds.size.width)! - 7 - 12, height: 70))
        titleLabel?.text = "titlelabel"
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        titleLabel?.textColor = UIColor.titleColor_Blue()
        self.contentView.addSubview(titleLabel!)
        
        tagLabel = UILabel(frame: CGRect(x: (titleLabel?.frame.origin.x)!, y: (coverImage?.frame.origin.y)! + (coverImage?.bounds.size.height)! - 70, width: screenWidth - (coverImage?.frame.origin.x)! - (coverImage?.bounds.size.width)! - 7 - 12, height: 70))
        tagLabel?.text = "tagLabel"
        tagLabel?.numberOfLines = 0
        tagLabel?.lineBreakMode = .byWordWrapping
        tagLabel?.font = UIFont.systemFont(ofSize: 14)
        tagLabel?.textColor = UIColor.messageColor()
        self.contentView.addSubview(tagLabel!)
        
        readButton = UIButton(frame: CGRect(x: 12, y: (coverImage?.frame.origin.y)! + (coverImage?.bounds.size.height)! + 18, width: screenWidth - 24, height: 40))
        readButton?.setTitle("阅读详情", for: .normal)
        readButton?.setTitleColor(UIColor.white, for: .normal)
        readButton?.adjustsImageWhenHighlighted = false
        readButton?.addTarget(self, action: #selector(self.readAction), for: .touchUpInside)
        self.contentView.addSubview(readButton!)
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 24, height: 40)
        gradientLayer.colors = [UIColor.beginColor().cgColor, UIColor.endColor().cgColor]
        readButton?.layer.addSublayer(gradientLayer)
        
        descTitleLabel = UILabel(frame: CGRect(x: 12, y: (readButton?.frame.origin.y)! + (readButton?.bounds.size.height)! + 20, width: 39, height: 25))
        descTitleLabel?.text = "简介"
        descTitleLabel?.textColor  = UIColor.titleColor_Blue()
        descTitleLabel?.font = UIFont.systemFont(ofSize: 18)
        descTitleLabel?.textAlignment = .left
        self.contentView.addSubview(descTitleLabel!)
        
        descriptionLabel = UILabel(frame: CGRect(x: 12, y: (descTitleLabel?.frame.origin.y)! + (descTitleLabel?.bounds.size.height)! + 11, width: screenWidth - 24, height: 115))
        descriptionLabel?.text = "简介"
        descriptionLabel?.numberOfLines = 0
        descriptionLabel?.lineBreakMode = .byWordWrapping
        descriptionLabel?.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel?.textColor = UIColor.messageColor()
        self.contentView.addSubview(descriptionLabel!)
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator?.frame = CGRect(x: 12 + (200 * scale - (activityIndicator?.bounds.size.width)!) * 0.5, y: 4 + 266 * scale * 0.5 - (activityIndicator?.bounds.size.height)!, width: (activityIndicator?.bounds.size.width)!, height: (activityIndicator?.bounds.size.height)!)
        activityIndicator?.hidesWhenStopped = true
        self.contentView.addSubview(activityIndicator!)
        
        activityIndicator?.startAnimating()
        
        self.contentView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (descriptionLabel?.frame.origin.y)! + (descriptionLabel?.bounds.size.height)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func cellHeight() -> CGFloat {
        return self.contentView.bounds.size.height + 20
    }
    
    func readClickColsure(colsure : ReadColsure?) {
        readColsure = colsure
    }
    
    @objc func readAction() {
        readColsure!()
    }

}
