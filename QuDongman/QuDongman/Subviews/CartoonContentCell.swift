//
//  CartoonContentCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/25.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import UIKit

class CartoonContentCell : JYBaseCell {
    
    var imageview:UIImageView!
    var activity:UIActivityIndicatorView?
    
    var imageName:String? {
        set {
            let queue = DispatchQueue(label: "load.image")
            queue.async {
                if (newValue)?.isEmpty == false {
                    let url = URL.init(string: newValue!)!
                    do {
                        let data : NSData = try NSData(contentsOf: url)
                        DispatchQueue.main.async {
                            self.imageview?.image = UIImage(data: data as Data)
                            self.activity?.stopAnimating()
                        }
                    } catch {}
                }
            }
        }
        
        get {
            return ""
        }
    }
    
    class func createCell(tableview: UITableView) -> CartoonContentCell {
        let identifier = "CartoonContentCell"
        var cell:CartoonContentCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? CartoonContentCell
        if cell == nil {
            cell = CartoonContentCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let scale = screenWidth / 320.0
        
        imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 320 * scale, height: 427 * scale))
        imageview.image = UIImage()
        self.contentView.addSubview(imageview)
        
        activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity?.frame = CGRect(x: (320 * scale - (activity?.bounds.size.width)!) * 0.5, y: (427 * scale - (activity?.bounds.size.height)!) * 0.5, width: (activity?.bounds.size.width)!, height: (activity?.bounds.size.height)!)
        activity?.hidesWhenStopped = true
        self.contentView.addSubview(activity!)
        
        activity?.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
