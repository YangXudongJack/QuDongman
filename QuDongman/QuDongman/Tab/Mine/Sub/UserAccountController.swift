//
//  UserAccountController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/3/25.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class UserAccountController: UIViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    class func create() ->  UserAccountController{
        let userAccount = UserAccountController(nibName: "UserAccountController", bundle: nil)
        userAccount.hidesBottomBarWhenPushed = true
        return userAccount
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "我的账户"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        hideTabbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createNavBackBtn()
        
        balanceLabel.text = "阅读币：".appending(JYUser.shared.balance!)
    }
    
    @IBAction func rechargeAction(_ sender: UIButton) {
        let buyCoin = UserBuyCoinController()
        self.navigationController?.pushViewController(buyCoin, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
