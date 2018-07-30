//
//  JYBannerCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYBannerCell: JYBaseCell {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var selectPoint: UIImageView!
    @IBOutlet weak var normalPoints: UIImageView!
    
    var index:Int?
    
    var _banners:NSMutableArray?
    var banners:NSMutableArray {
        set {
            _banners = newValue
            
            let size = UIScreen.main.bounds.size
            self.normalPoints.frame = CGRect(x: self.normalPoints.frame.origin.x, y: self.normalPoints.frame.origin.y, width: (63.0 / 4.0) * CGFloat(newValue.count), height: self.normalPoints.bounds.size.height)
            
            var count = 0;
            for banner in newValue {
                let recommend:JYRecommendObject = banner as! JYRecommendObject
                let imageview = UIImageView(frame: CGRect(x: Int(size.width * CGFloat(count)), y: 0, width: Int(size.width), height: 175))
                imageview.sd_setImage(with: URL(string: recommend.banner_image!), placeholderImage: UIImage(named: "bookCover_placeholder"), options: .retryFailed, completed: nil)
                let tap = UITapGestureRecognizer(target: self, action: #selector(booksSelected))
                imageview.addGestureRecognizer(tap)
                imageview.isUserInteractionEnabled = true
                scrollview.addSubview(imageview)
                count+=1
            }
            scrollview.contentSize = CGSize(width: Int(size.width) * count, height: 0)
        }
        
        get {
            return _banners!
        }
    }
    
    var bannerColsure:((JYRecommendObject)->Void)?
    
    class func createCell(tableview: UITableView, colsure:@escaping (JYRecommendObject)->Void) -> JYBannerCell{
        let identifier = "JYBannerCell"
        var cell:JYBannerCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYBannerCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("JYBannerCell", owner: nil, options: nil)?.first as! JYBannerCell
        }
        cell.bannerColsure = colsure;
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.index = 0;
        
        let size = UIScreen.main.bounds.size
        self.normalPoints.frame = CGRect(x: size.width - 22 - 63, y: self.contentView.bounds.size.height - 36, width: 0, height: 9)
        self.normalPoints.layer.masksToBounds = true
        self.selectPoint.frame = CGRect(x: self.normalPoints.frame.origin.x, y: self.normalPoints.frame.origin.y, width: self.selectPoint.bounds.size.width, height: self.selectPoint.bounds.size.height)
        
        var context = ""
        self.scrollview.addObserver(self, forKeyPath: "contentOffset", options: [.new, .old], context: &context)
    }
    
    @objc func booksSelected() {
        let recommend:JYRecommendObject = self.banners.object(at: self.index!) as! JYRecommendObject
        self.bannerColsure!(recommend)
    }
    
    func updateIndex() -> Void {
        let size = UIScreen.main.bounds.size
        self.index = Int(self.scrollview.contentOffset.x) / Int(size.width)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let size = UIScreen.main.bounds.size
        if self.scrollview.contentOffset.x > 0 && self.scrollview.contentOffset.x < size.width * CGFloat(self.banners.count - 1) {
            let offset:CGFloat = (self.scrollview.contentOffset.x / self.scrollview.contentSize.width) * (63.0 - 16.0)
            self.selectPoint.frame = CGRect(x: self.normalPoints.frame.origin.x + offset, y: self.normalPoints.frame.origin.y, width: self.selectPoint.bounds.size.width, height: self.selectPoint.bounds.size.height)
        }
        
        if Int(self.scrollview.contentOffset.x) % Int(size.width) == 0 {
            self.updateIndex()
        }
    }
    
}






