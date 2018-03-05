//
//  MineViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {
    
    class func create() -> MineViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "MineViewController") as! MineViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        let fixHeight = -64 + UIApplication.shared.statusBarFrame.height - 20
        self.tableView.contentInset = UIEdgeInsetsMake(fixHeight, 0, 0, 0 )
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isLogin() {
            var controller:UIViewController? = nil
            
            switch indexPath.section {
            case 0: do {
                switch indexPath.row {
                case 0: do{
                    controller = UserProfileController.create()
                    break
                }
                    
                default: do{
                    break
                    }
                }
                break
                }
                
            case 1: do{
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
                break
                }
                
            default: do{
                switch indexPath.row {
                case 0: do{
                    break
                    }
                    
                default: do{
                    break
                    }
                }
                }
            }
            
            self.navigationController?.pushViewController(controller!, animated: true)
        }
    }
    
    func isLogin() -> Bool {
        var login:Bool = false
        if JYUser.shared.id == nil {
            let loginVC = LoginViewController.create()
            self.present(loginVC, animated: true, completion: nil)
        }else{
            login = true
        }
        
        return login
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
