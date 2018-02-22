//
//  LoginViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginTypeTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var accountTFWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var shortcutLoginBtn: UIButton!
    
    @IBOutlet weak var accountLoginBtn: UIButton!
    
    @IBOutlet weak var accountTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var authorCodeBtn: UIButton!
    
    var timer:Timer?
    
    var count:Int?
    
    var isShortcut:Bool = false
    
    class func create() -> LoginViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if DeviceManager.isIphone4() {
            logoTopConstraint.constant = 15
            loginTypeTopConstraint.constant = 5
        }else if DeviceManager.isIphone5() || DeviceManager.isIphoneSE() {
            logoTopConstraint.constant = 45
            loginTypeTopConstraint.constant = 15
        }
        count = 60
    }

    @IBAction func shortcutLoginAction(_ sender: UIButton) {
        if !sender.isSelected {
            isShortcut = true
            sender.isSelected = true
            accountLoginBtn.isSelected = false
            registerBtn.alpha = 0.0
            forgetPasswordBtn.alpha = 0.0
            accountTF.placeholder = LanguageManager.localized(identifier: "login_shortcutAccountTF_placeholder")
            passwordTF.placeholder = LanguageManager.localized(identifier: "login_shortcutpwdTF_placeholder")
            
            let constant = accountTFWidthConstraint.constant
            accountTFWidthConstraint.constant = constant - 48;
            authorCodeBtn.isHidden = false
        }
    }
    
    @IBAction func accountLoginAction(_ sender: UIButton) {
        if !sender.isSelected {
            isShortcut = false
            sender.isSelected = true
            shortcutLoginBtn.isSelected = false
            registerBtn.alpha = 1.0
            forgetPasswordBtn.alpha = 1.0
            accountTF.placeholder = LanguageManager.localized(identifier: "login_accountTF_placeholder")
            passwordTF.placeholder = LanguageManager.localized(identifier: "login_passwordTF_placeholder")
            
            let constant = accountTFWidthConstraint.constant
            accountTFWidthConstraint.constant = constant + 48;
            authorCodeBtn.isHidden = true
        }
    }

    @IBAction func loginAction(_ sender: UIButton) {
        let url = JYUrl.shortcutLogin()
        var params:Dictionary<String, Any> = [:]
        if isShortcut {
            params["tel"] = accountTF.text
            params["signup_type"] = "2"
            params["code"] = passwordTF.text
            HttpUnit.HttpPost(url: url, params: params, responseObject: { (response, status) in
                
            })
        }
    }
    
    @IBAction func getAuthorCodeAction(_ sender: UIButton) {
        if !(accountTF.text?.isEmpty)! {
            if #available(iOS 10.0, *) {
                weak var weakself = self
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                    weakself?.countDown()
                })
            } else {
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LoginViewController.countDown), userInfo: nil, repeats: true)
            }
            
            let url = JYUrl.authorCode()
            HttpUnit.HttpPost(url: url, params: ["tel":accountTF.text as Any], responseObject: { (response, status) in
                
            })
        }else{
            
        }
    }
    
    @objc func countDown() -> Void {
        count = count! - 1;
        authorCodeBtn.titleLabel?.text = "\(count!)"
        authorCodeBtn.setTitle("\(count!)", for: .normal)
        
        if count == 0 {
            count = 60
            timer?.invalidate()
            timer = nil
            authorCodeBtn.setTitle(LanguageManager.localized(identifier: "login_getAuthorCode"), for: .normal)
            authorCodeBtn.isEnabled = true
        }else{
            authorCodeBtn.isEnabled = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
