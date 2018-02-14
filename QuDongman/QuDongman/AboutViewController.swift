//
//  AboutViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 27/10/2017.
//  Copyright © 2017 JackYang. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    var statusHeight: CGFloat?
    var navHeigh: CGFloat?
    var centerX: CGFloat?
    
    var titleLabel: UILabel?
    var descriptionLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.AboutBackgroundColor()
        self.title = "关于我们"
        
        statusHeight = UIApplication.shared.statusBarFrame.height
        navHeigh = self.navigationController?.navigationBar.frame.size.height
        centerX = UIScreen.main.bounds.size.width * 0.5
        
        initSubview()
    }
    
    func initSubview() -> Void {
        titleLabel = UILabel(frame: CGRect(x: centerX! - 79.5 * 0.5, y: statusHeight! + navHeigh! + 30, width: 79.5, height: 56.5))
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        titleLabel?.text = "关于我们"
        titleLabel?.textColor = UIColor.titleColor_Blue()
        self.view.addSubview(titleLabel!)
        
        
        let font = UIFont.systemFont(ofSize: 16)
        let text = "@2017 北京趣萌文化传媒有限公司\n工作时间: 9:30-18:30 \n客服QQ: 1830343590"
        let attributes = [NSAttributedStringKey.font:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let size = CGSize(width: centerX! * 2 - 24, height: 165.0)
        let rect:CGRect = text.boundingRect(with: size , options: option, attributes: attributes, context: nil)
        
        descriptionLabel = UILabel(frame: CGRect(x: 12, y: (titleLabel?.frame.origin.y)! + (titleLabel?.bounds.size.height)! + 16, width: centerX! * 2 - 24, height: rect.size.height))
        descriptionLabel?.textAlignment = .center
        descriptionLabel?.font = font
        descriptionLabel?.numberOfLines = 0
        descriptionLabel?.lineBreakMode = .byWordWrapping
        descriptionLabel?.textColor = UIColor.messageColor()
        
        descriptionLabel?.text = text
        self.view.addSubview(descriptionLabel!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
