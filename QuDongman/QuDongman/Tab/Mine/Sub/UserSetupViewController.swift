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
    
    @IBOutlet weak var cacheSizeLabel: UILabel!
    
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
    @IBAction func aboutAction(_ sender: UITapGestureRecognizer) {
        let controller = AboutViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
        createNavBackBtn()
        
        _refreshCacheInfo()
    }
    
    func _refreshCacheInfo() {
        let size:UInt = SDImageCache.shared().getSize()
        var sizeString = String()
        if size < 1024 {
            sizeString.append("\(String(format: "%.2f", CGFloat(size)))B")
        }else if size < 1024 * 1024 {
            sizeString.append("\(String(format: "%.2f", CGFloat(size)/1024.0))KB")
        }else{
            sizeString.append("\(String(format: "%.2f", CGFloat(size)/(1024.0*1024.0)))MB")
        }
        cacheSizeLabel.text = "\(sizeString)"
    }
    
    @IBAction func clearCache(_ sender: UITapGestureRecognizer) {
        JYProgressHUD.show()
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk(onCompletion: nil)
        _refreshCacheInfo()
        JYProgressHUD.dismiss()
        JYProgressHUD.showSuccess(success: "已清理")
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
