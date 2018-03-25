//
//  MineViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {
    
    var screenWidth: CGFloat = UIScreen.main.bounds.size.width
    
    class func create() -> MineViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "MineViewController") as! MineViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        var fixHeight = -64 + UIApplication.shared.statusBarFrame.height - 20
        if DeviceManager.isIphoneX() {
            fixHeight -= 40
        }
        self.tableView.contentInset = UIEdgeInsetsMake(fixHeight, 0, 0, 0 )
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0{
            if DeviceManager.isIphoneX() {
                return 160.0
            }else{
                return 120.0
            }
        }else {
            return 56.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var controller:UIViewController? = nil
        
        if indexPath.section == 0 {
            if self.isLogin() {
                switch indexPath.row {
                case 0: do{
                    controller = UserProfileController.create()
                    break
                    }
                    
                default: do{
                    controller = UserAccountController.create()
                    break
                    }
                }
            }else{
                return
            }
        }else if indexPath.section == 1 {
            if self.isLogin() {
                switch indexPath.row {
                case 0: do{
                    break
                    }
                    
                case 1: do{
                    break
                    }
                    
                default: do{
                    break
                    }
                }
            }else{
                return
            }
        }else{
            
        }
        
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func isLogin() -> Bool {
        var login:Bool = false
        if JYUser.shared.id == nil {
            let loginVC = LoginViewController.create()
            let nav = JYNavigationController(rootViewController: loginVC)
            self.present(nav, animated: true, completion: nil)
        }else{
            login = true
        }
        
        return login
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
