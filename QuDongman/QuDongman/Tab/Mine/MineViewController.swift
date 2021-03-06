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
    var logined:Bool?
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var headerImageview: UIImageView!
    
    class func create() -> MineViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "MineViewController") as! MineViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        showTabbar()
        
        logined = JYUser.exist()
        if logined! {
            self.usernameLabel.text = JYUser.shared.username
            self.headerImageview.sd_setImage(with: URL(string: JYUser.shared.avatar!), placeholderImage: UIImage(named: "mypg_user_img"), options: .retryFailed, completed: nil)
            self.tableView.reloadData()
        }else{
            self.usernameLabel.text = "请登录"
            self.headerImageview.image = UIImage(named: "mypg_user_img")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        var fixHeight = -64 + UIApplication.shared.statusBarFrame.height - 20
        if DeviceManager.isIphoneX() {
            fixHeight -= 40
        }
        if DeviceManager.isIphonePlus() {
            fixHeight += 8
        }
        self.tableView.contentInset = UIEdgeInsetsMake(fixHeight, 0, 0, 0 )
        headerImageview.layer.cornerRadius = 28.5
        headerImageview.layer.masksToBounds = true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0{
            if DeviceManager.isIphoneX() {
                return 160.0
            }else{
                return 120.0
            }
        }else {
            if indexPath.section == 1 && indexPath.row == 0{
                return 0
            }else{
                return 56.0
            }
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
                    controller = UserMessageController.create()
                    break
                    }
                    
                case 1: do{
                    controller = UserRechargeViewController()
                    let vc:UserRechargeViewController = controller as! UserRechargeViewController
                    vc.typeShopping = false
                    break
                    }
                    
                default: do{
                    controller = UserRechargeViewController()
                    let vc:UserRechargeViewController = controller as! UserRechargeViewController
                    vc.typeShopping = true
                    break
                    }
                }
            }else{
                return
            }
        }else{
            switch indexPath.row {
            case 0: do{
                return
                }
                
            default: do{
                weak var weakself = self
                controller = UserSetupViewController.create()
                let setup:UserSetupViewController = controller as! UserSetupViewController
                setup.logoutColsure {
                    weakself?.logined = false
                    weakself?.usernameLabel.text = "请登录"
                    weakself?.headerImageview.image = UIImage(named: "mypg_user_img")
                    weakself?.tableView.reloadData()
                }
                break
                }
            }
        }
        
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func isLogin() -> Bool {
        var login:Bool = false
        weak var weakself = self
        if logined! {
            login = true
        }else{
            let loginVC = LoginViewController.create()
            let nav = JYNavigationController(rootViewController: loginVC)
            loginVC.loginResultClosure {
                weakself?.logined = true
                weakself?.usernameLabel.text = JYUser.shared.username
                weakself?.headerImageview.sd_setImage(with: URL(string: JYUser.shared.avatar!), placeholderImage: UIImage(named: "mypg_user_img"), options: .retryFailed, completed: nil)
                weakself?.tableView.reloadData()
            }
            self.present(nav, animated: true, completion: nil)
        }
        return login
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
