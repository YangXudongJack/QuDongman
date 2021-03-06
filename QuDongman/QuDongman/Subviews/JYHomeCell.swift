//
//  JYHomeCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 28/10/2017.
//  Copyright © 2017 JackYang. All rights reserved.
//

import UIKit

class JYHomeCell: JYBaseCell {
    
    var coverImageview:UIImageView?
    var activityIndicator:UIActivityIndicatorView!

    var info:JYBanner? {
        set {
            let queue = DispatchQueue(label: "load.image")
            queue.async {
                let imageName = newValue?.banner_image!
                if imageName?.isEmpty == false {
                    let url = URL.init(string: imageName!)!
                    do {
                        let data : NSData = try NSData(contentsOf: url)
                        DispatchQueue.main.async {
                            self.coverImageview?.image = UIImage(data: data as Data)
                            self.activityIndicator.stopAnimating()
                        }
                    } catch {}
                }
            }
        }
        
        get {
            return nil
        }
    }
    
    
    class func createCell(tableview: UITableView) -> JYHomeCell{
        let identifier = "JYHomeCell"
        var homecell:JYHomeCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYHomeCell
        if homecell == nil {
            homecell = JYHomeCell.init(style: .default, reuseIdentifier: identifier)
        }
        return homecell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenWidth = UIScreen.main.bounds.size.width
        self.coverImageview = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 160 * UIScreen.main.bounds.size.width / 320))
        self.coverImageview?.image = UIImage()
        self.contentView.addSubview(self.coverImageview!)
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect(x: screenWidth*0.5 - activityIndicator.bounds.size.width * 0.5, y: 160 * UIScreen.main.bounds.size.width / 320 * 0.5 - activityIndicator.bounds.size.height * 0.5, width: activityIndicator.bounds.size.width, height: activityIndicator.bounds.size.height)
        activityIndicator.hidesWhenStopped = true
        self.contentView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
