//
//  RegisterViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/27.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var confirmPwdTF: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "注册页"
        createNavBackBtn()
    }
    
    @IBAction func textfieldEditChanged(_ sender: UITextField) {
        if sender == confirmPwdTF || sender == passwordTF {
            if confirmPwdTF.text == passwordTF.text {
                registerBtn.isEnabled = true
            }else{
                registerBtn.isEnabled = false
            }
        }
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        weak var weakself = self
        HttpUnit.fastRegister(params: { () -> Dictionary<String, Any> in
            var params:Dictionary<String, Any> = [:]
            params["username"] = weakself?.usernameTF.text
            params["signup_type"] = "1"
            params["password"] = weakself?.passwordTF.text
            params["rpassword"] = weakself?.confirmPwdTF.text
            return params
        }, responseObject: { (response, status) in
            if status {
                let data = response.object(forKey: "data")
                JYUser.shared.update(dict: data as! [String : AnyObject])
                
                //登陆成功
            }
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
