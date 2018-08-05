//
//  JYCommentEditView.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/28.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit
import Alamofire

class JYCommentEditView: UIView , UITextFieldDelegate{

    var backgroundImageview:UIImageView?
    var commentTextField: UITextField!
    var sendButton: UIButton!
    
    var bookId:String?
    var chapterId:String?
    var pid:String?
    var to_member_id:String?
    
    var commentColsure:(()->Void)?
    
    class func showAddCommentView(frame:CGRect, colsure:@escaping ()->Void) -> JYCommentEditView{
        let editview:JYCommentEditView = JYCommentEditView(frame: frame)
        editview.commentColsure = colsure
        return editview
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.separatorColor()
        
        let size = frame.size
        backgroundImageview = UIImageView(frame: CGRect(x: 12.0,
                                                        y: 8.5,
                                                        width: size.width - 102,
                                                        height: 39))
        backgroundImageview?.image = UIImage(named: "input_bottom")
        self.addSubview(backgroundImageview!)
        
        commentTextField = UITextField(frame: CGRect(x: 36, y: 8.5, width: size.width - 150, height: 39))
        commentTextField.delegate = self
        commentTextField.returnKeyType = .done
        self.addSubview(commentTextField)
        
        sendButton = UIButton(frame: CGRect(x: size.width - 76, y: 10, width: 65, height: 36))
        sendButton.isEnabled = false
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        sendButton.setTitle("发送", for: .normal)
        sendButton.setTitleColor(UIColor.buttonTitle(), for: .disabled)
        sendButton.setBackgroundImage(UIImage(named: "send_grey_disabled"), for: .disabled)
        sendButton.setTitleColor(UIColor.AboutBackgroundColor(), for: .normal)
        sendButton.setBackgroundImage(UIImage(named: "btn_send_nor"), for: .normal)
        sendButton.addTarget(self, action: #selector(addCommentAction(_:)), for: .touchUpInside)
        self.addSubview(sendButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let rag = textField.text?.toRange(range)
        let string = textField.text?.replacingCharacters(in: rag!, with: string)
        
        if (string?.characters.count)! > 0 {
            sendButton.isEnabled = true
        }else{
            sendButton.isEnabled = false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    @objc func addCommentAction(_ sender: UIButton) {
        JYProgressHUD.show()
        
        var params:Parameters = Parameters.init()
        params["to_member_id"] = to_member_id
        params["book_id"] = bookId
        params["chapter_id"] = chapterId
        params["content"] = commentTextField.text
        params["pid"] = pid
        HttpUnit.HttpPost(url: JYUrl.addComments(), params: params) { (response, success) in
            JYProgressHUD.dismiss()
            if success {
                let result:String = response.object(forKey: "code") as! String
                if Int(result) == 1 {
                    self.commentColsure!()
                    self.commentTextField.text = nil
                    self.sendButton.isEnabled = false
                }
            }
        }
    }
    
}
