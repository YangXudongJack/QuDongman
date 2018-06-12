//
//  UserProfileController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/3/5.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    class func create() ->  UserProfileController{
        let userProfile = UserProfileController(nibName: "UserProfileController", bundle: nil)
        return userProfile
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "我的"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        hideTabbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createNavBackBtn()
        
        accountLabel.text = JYUser.shared.id
        usernameLabel.text = JYUser.shared.username
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
