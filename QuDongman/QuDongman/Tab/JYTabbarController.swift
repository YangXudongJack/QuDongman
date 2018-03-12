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
    
    var tabbarWidth: CGFloat = 44
    var tabbarHeight: CGFloat = 49
    var tabbarViewHeight: CGFloat = 50
    
    var tabbarVessel: UIView?
    
    
    var tabbarButtons = [UIButton]()
    var tabbarImages = ["tab_home_normal", "tab_books_normal", "tab_search_normal", "tab_mine_normal"]
    var tabbarImages_selected = ["tab_home_selected", "tab_books_selected", "tab_search_selected", "tab_mine_selected"]
    
    var selectorArr = ["homeSelected:", "booksSelected:", "searchSelected:", "mineSelected:"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.size.width
        screenHeight = screenFrame.size.height
        self.tabBar.isHidden = true
        
        initControllers()
        customTabbar()
    }
    
    func initControllers() -> Void {
        let home = HomeViewController()
        let about = AboutViewController()
        let search = SearchViewController()
        let mine = MineViewController.create()
        
        var views = [home, about, search, mine]
        var controllers = [UIViewController]()
        for index in 0..<views.count{
            let nav = JYNavigationController(rootViewController: views[index])
            controllers.append(nav)
        }
        self.viewControllers = controllers
    }
    
    func customTabbar() -> Void{
        var fixOriginY:CGFloat = 0
        if DeviceManager.isIphoneX() {
            fixOriginY = 20
        }
        tabbarVessel = UIView(frame: CGRect(x: 0, y: screenHeight! - tabbarViewHeight - fixOriginY, width: screenWidth!, height: tabbarViewHeight + fixOriginY))
        tabbarVessel?.backgroundColor = UIColor.white
        self.view.addSubview(tabbarVessel!)
        
        let tabbarview = UIView(frame: CGRect(x: 0, y: 1, width: screenWidth!, height: tabbarHeight))
        tabbarVessel?.addSubview(tabbarview)
        
        let line = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth!, height: 1))
        line.image = UIImage(named: "tab_Line")
        tabbarVessel?.addSubview(line)
        
        var originX:CGFloat = 0.0
        let gap = (screenWidth! - tabbarWidth * 4) / CGFloat((selectorArr.count * 2))
        for index in 0..<tabbarImages.count {
            let btn = JYButton(type: UIButtonType.custom)
            originX = gap + CGFloat(index) * (2 * gap + tabbarWidth)
            btn.frame = CGRect(x: originX, y: 3.0, width: tabbarWidth, height: tabbarHeight - 5)
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
    
    @objc func booksSelected(_ sender: JYButton) {
        sender.isSelected = true
        resetOtherButtons(sender: sender)
        self.selectedIndex = 1;
    }
    
    @objc func searchSelected(_ sender: JYButton) {
        sender.isSelected = true
        resetOtherButtons(sender: sender)
        self.selectedIndex = 2;
    }
    
    @objc func mineSelected(_ sender: JYButton) {
        sender.isSelected = true
        resetOtherButtons(sender: sender)
        self.selectedIndex = 3;
    }
    
    func resetOtherButtons(sender: JYButton) -> Void {
        for index in 0..<tabbarButtons.count {
            let btn = tabbarButtons[index]
            if !sender.isEqual(btn){
                btn.isSelected = false
            }
        }
    }
    
    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
