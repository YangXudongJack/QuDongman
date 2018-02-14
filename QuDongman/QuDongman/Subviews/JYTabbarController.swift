//
//  JYTabbarController.swift
//  QuDongman
//
//  Created by 杨旭东 on 27/10/2017.
//  Copyright © 2017 JackYang. All rights reserved.
//

import UIKit

class JYTabbarController: UITabBarController {
    
    var screenWidth: CGFloat?
    var screenHeight:  CGFloat?
    
    var tabbarWidth: CGFloat?
    var tabbarHeight: CGFloat = 49
    var tabbarViewHeight: CGFloat = 50
    
    var tabbarVessel: UIView?
    
    
    var tabbarButtons = [UIButton]()
    var tabbarImages = ["tab_home_nor", "tab_about_nor"]
    var tabbarImages_selected = ["tab_home_press", "tab_about_press"]
    
    var selectorArr = ["homeSelected:", "aboutSelected:"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.size.width
        screenHeight = screenFrame.size.height
        
        tabbarWidth = screenWidth! * 0.5
        self.tabBar.isHidden = true
        
        initControllers()
        customTabbar()
    }
    
    func initControllers() -> Void {
        let home = HomeViewController()
        let about = AboutViewController()
        
        var views = [home, about]
        var controllers = [UIViewController]()
        for index in 0..<views.count{
            let nav = JYNavigationController(rootViewController: views[index])
            controllers.append(nav)
        }
        self.viewControllers = controllers
    }
    
    func customTabbar() -> Void{
        tabbarVessel = UIView(frame: CGRect(x: 0, y: screenHeight! - tabbarViewHeight, width: screenWidth!, height: tabbarViewHeight))
        tabbarVessel?.backgroundColor = UIColor.white
        self.view.addSubview(tabbarVessel!)
        
        let tabbarview = UIView(frame: CGRect(x: 0, y: 1, width: screenWidth!, height: tabbarHeight))
        tabbarVessel?.addSubview(tabbarview)
        
        let line = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth!, height: 1))
        line.image = UIImage(named: "tab_Line")
        tabbarVessel?.addSubview(line)
        
        
        for index in 0..<tabbarImages.count {
            let btn = JYButton(type: UIButtonType.custom)
            btn.frame = CGRect(x: CGFloat(index) * tabbarWidth!, y: 1, width: tabbarWidth!, height: tabbarHeight)
            btn.setBackgroundImage(UIImage(named: tabbarImages[index]), for: .normal)
            btn.setBackgroundImage(UIImage(named: tabbarImages_selected[index]), for: .highlighted)
            btn.setBackgroundImage(UIImage(named: tabbarImages_selected[index]), for: .selected)
            btn.adjustsImageWhenHighlighted = false
            
            let selector: Selector = NSSelectorFromString(selectorArr[index])
            btn.addTarget(self, action:selector, for: .touchUpInside)
            btn.addTarget(self, action:selector, for: .touchDown)
            tabbarview.addSubview(btn)
            
            if index == 0 {
                btn.isSelected = true
            }
            tabbarButtons.append(btn)
        }
    }
    
    @objc func homeSelected(_ sender: JYButton) {
        sender.isSelected = true
        resetOtherButtons(sender: sender)
        self.selectedIndex = 0;
    }
    
    @objc func aboutSelected(_ sender: JYButton) {
        sender.isSelected = true
        resetOtherButtons(sender: sender)
        self.selectedIndex = 1;
    }
    
    func resetOtherButtons(sender: JYButton) -> Void {
        for index in 0..<tabbarButtons.count {
            let btn = tabbarButtons[index]
            if !sender.isEqual(btn){
                btn.isSelected = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
