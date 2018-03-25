//
//  UserAccountController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/3/25.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class UserAccountController: UIViewController {
    
    class func create() ->  UserAccountController{
        let userAccount = UserAccountController(nibName: "UserAccountController", bundle: nil)
        userAccount.hidesBottomBarWhenPushed = true
        return userAccount
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createNavBackBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
