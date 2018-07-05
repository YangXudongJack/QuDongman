//
//  SearchDetailController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/6/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class SearchDetailController: UIViewController, UISearchBarDelegate {
    
    var searchBar:UISearchBar?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        hideTabbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configSearchbar()
    }
    
    func configSearchbar() -> Void {
        let size = self.view.bounds.size
        searchBar = UISearchBar(frame: CGRect(x: 17, y: 8, width: size.width - 17 * 2, height: 28))
        searchBar?.setShowsCancelButton(true, animated: true)
        searchBar?.delegate = self
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "取消"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).isEnabled = true
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.white], for: .normal)
        let searchField:UITextField = searchBar?.value(forKey: "searchField") as! UITextField
//        searchField.attributedPlaceholder
//        searchField.setValue(UIColor.titleColor_lightDark(), forKey: "placeholderLabel.textColor")
        searchField.font = UIFont.systemFont(ofSize: 13)
        self.navigationItem.titleView = searchBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView.init())
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
