//
//  JYNavigationController.swift
//  QuDongman
//
//  Created by 杨旭东 on 27/10/2017.
//  Copyright © 2017 JackYang. All rights reserved.
//

import UIKit

class JYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        resetConfig()
    }
    
    func changeConfig() -> Void {
        self.navigationBar.barTintColor = UIColor.AboutBackgroundColor()
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.NavigationColor()]
        self.navigationBar.isTranslucent = false
    }
    
    func resetConfig() -> Void {
        self.navigationBar.barTintColor = UIColor.NavigationColor()
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationBar.isTranslucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
