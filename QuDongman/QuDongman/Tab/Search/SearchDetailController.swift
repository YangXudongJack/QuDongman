//
//  SearchDetailController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/6/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class SearchDetailController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        hideTabbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createNavBackBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
