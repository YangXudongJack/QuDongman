//
//  UserProfileController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/3/5.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {
    
    class func create() ->  UserProfileController{
        let userProfile = UserProfileController(nibName: "UserProfileController", bundle: nil)
        return userProfile
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
