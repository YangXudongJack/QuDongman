//
//  UserSetupViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/5/21.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class UserSetupViewController: UIViewController {
    
    var LogoutColsure:(() -> Void)?
    
    class func create() ->  UserSetupViewController{
        let userAccount = UserSetupViewController(nibName: "UserSetupViewController", bundle: nil)
        userAccount.hidesBottomBarWhenPushed = true
        return userAccount
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        hideTabbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
        createNavBackBtn()
    }
    
    @IBAction func logout(_ sender: UIButton) {
        if LogoutColsure != nil {
            UserDefaults.standard.removeObject(forKey: JYUser.JYUserData)
            LogoutColsure!()
        }
        
        weak var weakself = self
        JYUser.shared.clear {
            weakself?.navigationController?.popViewController(animated: true)
        }
    }
    
    func logoutColsure(colsure: @escaping () -> Void) -> Void {
        LogoutColsure = colsure
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
