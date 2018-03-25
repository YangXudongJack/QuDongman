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
    
    @IBOutlet weak var quickLoginBottomConstraint: NSLayoutConstraint!
    
    var timer:Timer?
    
    var count:Int?
    
    var isShortcut:Bool = false
    
    class func create() -> LoginViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if DeviceManager.isIphone4() {
            logoTopConstraint.constant = 15
            loginTypeTopConstraint.constant = 5
        }else if DeviceManager.isIphone5() || DeviceManager.isIphoneSE() {
            logoTopConstraint.constant = 45
            loginTypeTopConstraint.constant = 15
        }
        count = 60
        
        self.hideTabbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.showTabbar()
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
        if isShortcut {
            weak var weakself = self
            HttpUnit.fastRegister(params: { () -> Dictionary<String, Any> in
                var params:Dictionary<String, Any> = [:]
                params["tel"] = weakself?.accountTF.text
                params["signup_type"] = "2"
                params["code"] = weakself?.passwordTF.text
                return params
            }, responseObject: { (response, status) in
                if status {
                    let data = response.object(forKey: "data")
                    JYUser.shared.update(dict: data as! [String : AnyObject])
                    
                    weakself?.dismiss(animated: true, completion: nil)
                }
            })
        }else{
            weak var weakself = self
            HttpUnit.login(params: { () -> Dictionary<String, Any> in
                var params:Dictionary<String, Any> = [:]
                params["username"] = weakself?.accountTF.text
                params["password"] = weakself?.passwordTF.text
                return params
            }, responseObject: { (response, status) in
                if status {
                    let data = response.object(forKey: "data")
                    JYUser.shared.update(dict: data as! [String : AnyObject])
                    
                    weakself?.dismiss(animated: true, completion: nil)
                }
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
            
            HttpUnit.getAuthCode(number: accountTF.text!)
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
    
    @IBAction func WeChatLogin(_ sender: UIButton) {
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "App"
        
        weak var weakself = self
        if WXApi.send(req) {
            ShareManager.shared.shareResultClosure(closure: {
                weakself?.dismiss(animated: true, completion: nil)
            })
        }else{
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
