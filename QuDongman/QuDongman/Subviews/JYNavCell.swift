//
//  JYNavCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYNavCell: JYBaseCell {
    
    @IBOutlet weak var stackview: UIStackView!
    
    var _navs:NSMutableArray?
    var navs:NSMutableArray? {
        set {
            _navs = newValue
            
            var tag = 1
            for item in newValue! {
                let nav:JYNav = item as! JYNav
                let view = stackview.viewWithTag(tag)
                view?.isHidden = false
                let imageview:UIImageView = view!.viewWithTag(tag * 10 + 1) as! UIImageView
                let label:UILabel = view!.viewWithTag(tag * 10 + 2) as! UILabel
                label.text = nav.nav_name;
                imageview.sd_setImage(with: URL(string: nav.nav_image!), placeholderImage: nil, options: .retryFailed, completed: nil)
                tag+=1
            }
        }
        
        get {
            return _navs
        }
    }
    
    var navColsure:((JYNav)->Void)?
    
    class func createCell(tableview: UITableView, colsure:@escaping (JYNav)->Void) -> JYNavCell{
        let identifier = "JYNavCell"
        var cell:JYNavCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYNavCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("JYNavCell", owner: nil, options: nil)?.first as! JYNavCell
        }
        cell.navColsure = colsure
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func selectNav1(_ sender: UITapGestureRecognizer) {
        let nav:JYNav = self.navs![0] as! JYNav
        self.navColsure!(nav);
    }
    
    @IBAction func selectNav2(_ sender: UITapGestureRecognizer) {
        let nav:JYNav = self.navs![1] as! JYNav
        self.navColsure!(nav);
    }
    
    @IBAction func selectNav3(_ sender: UITapGestureRecognizer) {
        let nav:JYNav = self.navs![2] as! JYNav
        self.navColsure!(nav);
    }
    
    @IBAction func selectNav4(_ sender: UITapGestureRecognizer) {
        let nav:JYNav = self.navs![3] as! JYNav
        self.navColsure!(nav);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
