//
//  BookContentController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class BookContentController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var id:String?
    var chapter:String?
    var cartoonTitle:String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var cartoonContent:JYCartoonContent?
    
    @IBOutlet weak var collectButton: UIButton!
    @IBOutlet weak var titleBackViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var toolbar: [UIView]!
    var didScroll:Bool?
    
    class func bookContent(id:String, chapter:String, title:String) -> BookContentController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let book = storyboard.instantiateViewController(withIdentifier: "BookContentController") as! BookContentController
        book.id = id
        book.chapter = chapter
        book.cartoonTitle = title
        return book
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        didScroll = false
        titleLabel.text = cartoonTitle
        if DeviceManager.isIphoneX() {
            titleBackViewHeightConstraint.constant = 88
        }
        for view in toolbar {
            view.backgroundColor = UIColor.boardColor().withAlphaComponent(0.9)
        }
        collectButton.backgroundColor = UIColor.boardColor().withAlphaComponent(0.5)
        _fetchData()
        HttpUnit.addHistory(id: id!, chapter: chapter!)
    }
    
    func _fetchData() -> Void {
        JYProgressHUD.show()
        HttpUnit.HttpGet(url: JYUrl.content(id: Int(id!)!, chapter: Int(chapter!)!)) { (responseObject, success) in
            if success {
                let data = responseObject.object(forKey: "data")
                self.cartoonContent = JYCartoonContent.init(dict: data as! [String : AnyObject])
                self.tableview?.reloadData()
            }
            JYProgressHUD.dismiss()
        }
    }
    
    @IBAction func addCollection(_ sender: UIButton) {
        HttpUnit.addCollection(id: id!)
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let scale = screenWidth / 320.0
        return 427 * scale
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartoonContent == nil {
            return 0
        }else{
            return (cartoonContent?.content_results?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CartoonContentCell.createCell(tableview: tableView)
        cell.imageName = self.cartoonContent?.content_results![indexPath.row] as! String
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        didScroll = true
        for view in toolbar {
            UIView.animate(withDuration: 0.5) {
                view.alpha = 1
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if didScroll! {
            for view in toolbar {
                UIView.animate(withDuration: 0.5) {
                    view.alpha = 0
                }
            }
        }
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        didScroll = true
        for view in toolbar {
            UIView.animate(withDuration: 0.5) {
                view.alpha = 1
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
