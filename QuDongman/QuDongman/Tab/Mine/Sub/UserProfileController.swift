//
//  UserProfileController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/3/5.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit
import Alamofire

class UserProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var headerImageview: UIImageView!
    
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
        
        headerImageview.layer.cornerRadius = 39.5
        headerImageview.layer.masksToBounds = true
    }
    
    @IBAction func changeUserName(_ sender: UITapGestureRecognizer) {
        var inputText:UITextField = UITextField();
        let msgAlertCtr = UIAlertController.init(title: "提示", message: "请输入用户名", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "确定", style:.default) { (action:UIAlertAction) ->() in
            if((inputText.text?.characters.count)! > 0){
                self._updateUserName(name: inputText.text!)
            }
        }
        
        let cancel = UIAlertAction.init(title: "取消", style:.cancel) { (action:UIAlertAction) -> ()in
            print("取消输入")
        }
        
        msgAlertCtr.addAction(ok)
        msgAlertCtr.addAction(cancel)
        msgAlertCtr.addTextField { (textField) in
            inputText = textField
            inputText.placeholder = "用户名"
        }
        self.present(msgAlertCtr, animated: true, completion: nil)
    }
    
    @IBAction func pickHeaderImage(_ sender: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //设置是否允许编辑
            picker.allowsEditing = true
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    
    func _updateUserName(name:String) -> Void {
        var params:Parameters = Parameters.init()
        params["avatar"] = ""
        params["nickname"] = name
        
        JYProgressHUD.show()
        HttpUnit.HttpPut(url: JYUrl.updateUserInfo(), params: params) { (response, success) in
            JYProgressHUD.dismiss()
            if success {
                let result:String = response.object(forKey: "code") as! String
                
                if Int(result) == 1 {
                    self.usernameLabel.text = name
                    JYUser.shared.username = name
                    JYUser.shared.updateBalance()
                    JYProgressHUD.showSuccess(success: "修改成功")
                }else{
                    JYProgressHUD.showFailed(failed: "修改失败")
                }
            }
        }
    }
    
    func _updateUserImage(image:UIImage) -> Void {
        var params:Parameters = Parameters.init()
        let data = UIImagePNGRepresentation(image)
        params["avatar"] = data?.base64EncodedString()
        params["nickname"] = JYUser.shared.username
        
        JYProgressHUD.show()
        HttpUnit.HttpPut(url: JYUrl.updateUserInfo(), params: params) { (response, success) in
            JYProgressHUD.dismiss()
            if success {
                let result:String = response.object(forKey: "code") as! String
                
                if Int(result) == 1 {
                    JYUser.shared.updateBalance()
                    self.headerImageview.image = image
                    JYProgressHUD.showSuccess(success: "修改成功")
                }else{
                    JYProgressHUD.showFailed(failed: "修改失败")
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        print(info)
        
        //显示的图片
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self._updateUserImage(image: image)
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
