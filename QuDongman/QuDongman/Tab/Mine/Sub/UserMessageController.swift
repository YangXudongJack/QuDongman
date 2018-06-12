//
//  UserMessageController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/6/5.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class UserMessageController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var systemMessageButton: UIButton!
    
    @IBOutlet weak var userMessageButton: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    
    class func create() -> UserMessageController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "UserMessageController") as! UserMessageController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        hideTabbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的消息"
        createNavBackBtn()
        tableview.tableFooterView = UIView.init()
    }

    @IBAction func fetchSystemMessage(_ sender: UIButton) {
        systemMessageButton.isSelected = true
        userMessageButton.isSelected = false
    }
    
    @IBAction func fetchUserMessage(_ sender: UIButton) {
        systemMessageButton.isSelected = false
        userMessageButton.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "JYMessageCell"
        let cell:JYMessageCell! = tableview.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? JYMessageCell
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
