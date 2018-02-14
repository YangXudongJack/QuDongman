//
//  UIViewController+Extension.swift
//  QuDongman
//
//  Created by 杨旭东 on 29/10/2017.
//  Copyright © 2017 JackYang. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{
    func createNavBackBtn() -> Void {
        let backBtn = UIBarButtonItem(image: UIImage(named: "nav_back_icon"), style: .done, target: self, action: #selector(UIViewController.dismissview))
        backBtn.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc func dismissview() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    func hideTabbar() -> Void {
        let screensize = UIScreen.main.bounds.size
        let tabbar: JYTabbarController = UIApplication.shared.keyWindow?.rootViewController as! JYTabbarController
        UIView.animate(withDuration: 0.3, animations: { 
            tabbar.tabbarVessel?.frame = CGRect(x: 0, y: screensize.height, width: (tabbar.tabbarVessel?.bounds.size.width)!, height: (tabbar.tabbarVessel?.bounds.size.height)!)
        }) { (finish) in
            if finish {
                tabbar.tabbarVessel?.isHidden = true
            }
        }
    }
    
    func showTabbar() -> Void {
        let screensize = UIScreen.main.bounds.size
        let tabbar: JYTabbarController = UIApplication.shared.keyWindow?.rootViewController as! JYTabbarController
        UIView.animate(withDuration: 0.1, animations: {
            tabbar.tabbarVessel?.frame = CGRect(x: 0, y: screensize.height - (tabbar.tabbarVessel?.bounds.size.height)!, width: (tabbar.tabbarVessel?.bounds.size.width)!, height: (tabbar.tabbarVessel?.bounds.size.height)!)
        }) { (finish) in
            if finish {
                tabbar.tabbarVessel?.isHidden = false
            }
        }
    }
}
