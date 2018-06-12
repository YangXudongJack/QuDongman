//
//  SearchViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var statuebarBackgroundHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var spaceConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var tableviewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var payButton: UIButton!
    
    @IBOutlet weak var popularButton: UIButton!
    
    @IBOutlet weak var awardButton: UIButton!
    
    var categories:NSMutableArray?
    
    @IBOutlet var categoriesButtons: [UIButton]!
    
    class func create() -> SearchViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let size = UIScreen.main.bounds.size
        statuebarBackgroundHeightConstraint.constant = UIApplication.shared.statusBarFrame.size.height
        tableviewHeightConstraint.constant = size.height - UIApplication.shared.statusBarFrame.size.height - 64 - 137 - 50 - (DeviceManager.isIphoneX() ?20:0) - 31
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        showTabbar()
        
        let gap:CGFloat = (self.view.bounds.size.width - 50 * 5 - 34)/4
        for constraint in spaceConstraints {
            constraint.constant = gap
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCategory()
    }
    
    func fetchCategory() -> Void {
        
        self.categories = NSMutableArray.init()
        HttpUnit.HttpGet(url: JYUrl.category()) { (response, status) in
            if status {
                let categories:NSArray = response.object(forKey: "data") as! NSArray
                for item in categories {
                    self.categories?.add(JYCategory.init(dict: item as! [String : AnyObject]))
                }
                self.refreshCategories()
            }
        }
    }
    
    func refreshCategories() -> Void {
        var i:Int = 0
        for button in categoriesButtons {
            if i < (self.categories?.count)! {
                let category:JYCategory = self.categories?.object(at: i) as! JYCategory
                button.setTitle(category.cat_name, for: .normal)
                button.isHidden = false
                i+=1
            }
        }
    }

    @IBAction func showSearchViewController(_ sender: UIButton) {
        
    }
    
    @IBAction func payList(_ sender: UIButton) {
        payButton.isSelected = true
        popularButton.isSelected = false
        awardButton.isSelected = false
    }
    
    @IBAction func popularList(_ sender: UIButton) {
        payButton.isSelected = false
        popularButton.isSelected = true
        awardButton.isSelected = false
    }
    
    @IBAction func awardList(_ sender: UIButton) {
        payButton.isSelected = false
        popularButton.isSelected = false
        awardButton.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "JYCoverCell"
        let cell:JYCoverCell! = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? JYCoverCell
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
