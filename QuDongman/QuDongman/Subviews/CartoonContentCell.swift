//
//  CartoonContentCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/25.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import UIKit

class CartoonContentCell : UITableViewCell {
    
    var imageview: UIImageView!
    var activity:UIActivityIndicatorView?
    
    class func createCell(tableview: UITableView, info: NSString, indexPath : IndexPath) -> CartoonContentCell {
        let identifier = String.init("identifier\(indexPath.row)")
        var cell:CartoonContentCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? CartoonContentCell
        if cell == nil {
            cell = CartoonContentCell.init(style: .default, reuseIdentifier: identifier)
        }
        
        let queue = DispatchQueue(label: "load.image")
        queue.async {
            let imageName = info
            if (imageName as String).isEmpty == false {
                let url = URL.init(string: imageName as String)!
                do {
                    let data : NSData = try NSData(contentsOf: url)
                    DispatchQueue.main.async {
                        cell.imageview?.image = UIImage(data: data as Data)
                        cell.activity?.stopAnimating()
                    }
                } catch {}
            }
        }
        
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
