//
//  JYNewHomeCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYNewHomeCell: JYBaseCell {

    @IBOutlet var views: [UIView]!
    
    var _recommends:NSMutableArray?
    var recommends:NSMutableArray? {
        set {
            _recommends = newValue
            
            var index:Int = 1
            for item in newValue! {
                let recommend:JYRecommendObject = item as! JYRecommendObject
                let view = self.contentView.viewWithTag(index)
                view?.isHidden = false
                let imageview:UIImageView = view?.viewWithTag(11) as! UIImageView
                let titleLabel:UILabel = view?.viewWithTag(12) as! UILabel
                let descLabel:UILabel = view?.viewWithTag(13) as! UILabel
                
                imageview.sd_setImage(with: URL(string: recommend.banner_image!), placeholderImage: UIImage(named: "bookCover_placeholder"), options: .retryFailed, completed: nil)
                titleLabel.text = recommend.name
                descLabel.text = recommend.descp_short
                index+=1
            }
        }
        
        get {
            return _recommends
        }
    }
    
    var homeColsure:((JYRecommendObject)->Void)?
    
    class func createCell(tableview: UITableView, colsure:@escaping (JYRecommendObject)->Void) -> JYNewHomeCell{
        let identifier = "JYNewHomeCell"
        var cell:JYNewHomeCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYNewHomeCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("JYNewHomeCell", owner: nil, options: nil)?.first as! JYNewHomeCell
        }
        cell.homeColsure = colsure
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func selectedBook1(_ sender: UITapGestureRecognizer) {
        let recommend:JYRecommendObject = recommends?.object(at: 0) as! JYRecommendObject
        self.homeColsure!(recommend)
    }
    
    @IBAction func selectedBook2(_ sender: UITapGestureRecognizer) {
        let recommend:JYRecommendObject = recommends?.object(at: 1) as! JYRecommendObject
        self.homeColsure!(recommend)
    }
    
    @IBAction func selectedBook3(_ sender: UITapGestureRecognizer) {
        let recommend:JYRecommendObject = recommends?.object(at: 2) as! JYRecommendObject
        self.homeColsure!(recommend)
    }
    
    @IBAction func selectedBook4(_ sender: UITapGestureRecognizer) {
        let recommend:JYRecommendObject = recommends?.object(at: 3) as! JYRecommendObject
        self.homeColsure!(recommend)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
