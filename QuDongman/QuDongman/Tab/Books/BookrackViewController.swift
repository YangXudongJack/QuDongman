//
//  BookrackViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/5/24.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

enum JYBookrackType {
    case placeholder
    case collect
    case history
}

class BookrackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var statuebarBackgroundHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectviewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bookrackEmptyHeaderConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectButton: UIButton!
    
    @IBOutlet weak var historyButton: UIButton!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var collections:NSMutableArray?
    var type:JYBookrackType?
    
    class func create() -> BookrackViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "BookrackViewController") as! BookrackViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let size = UIScreen.main.bounds.size
        statuebarBackgroundHeightConstraint.constant = UIApplication.shared.statusBarFrame.size.height
        collectviewHeightConstraint.constant = size.height - UIApplication.shared.statusBarFrame.size.height - 44 - 50 - (DeviceManager.isIphoneX() ?20:0) - 40
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if JYUser.exist() {
            if type == .placeholder {
                type = .collect
            }
        }else{
            type = .placeholder
        }
        
        if type == .collect {
            _fetchCollection()
        }else if type == .history{
            _fetchHistories()
        }else{
            collections?.removeAllObjects()
            collectionview.reloadData()
        }
        
        showTabbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collections = NSMutableArray()
        
        if JYUser.exist() {
            type = .collect
        }else{
            type = .placeholder
        }
    }
    
    @IBAction func collectAction(_ sender: UIButton) {
        collectButton.isSelected = true
        historyButton.isSelected = false
        type = .collect
        _fetchCollection()
    }
    
    @IBAction func historyAction(_ sender: UIButton) {
        collectButton.isSelected = false
        historyButton.isSelected = true
        type = .history
        _fetchHistories()
    }
    
    @IBAction func closeBookrackEmptyRecommend(_ sender: UIButton) {
        let size = UIScreen.main.bounds.size
        bookrackEmptyHeaderConstraint.constant = 0
        collectviewHeightConstraint.constant = size.height - UIApplication.shared.statusBarFrame.size.height - 44 - 50 - (DeviceManager.isIphoneX() ?20:0)
    }
    
    func _fetchCollection() -> Void {
        JYProgressHUD.show()
        collections?.removeAllObjects()
        HttpUnit.HttpGet(url: JYUrl.collect()) { (reponseObject, success) in
            if success {
                let books:AnyObject = reponseObject.object(forKey: "data") as AnyObject
                if books.isKind(of: NSArray.self) {
                    let bookCollections = books as! NSArray
                    for item in bookCollections {
                        self.collections?.add(JYCollection.init(dict: item as! [String : AnyObject]))
                    }
                    self.closeBookrackEmptyRecommend(UIButton())
                }
                self.collectionview.reloadData()
            }
            JYProgressHUD.dismiss()
        }
    }
    
    func _fetchHistories() -> Void {
        JYProgressHUD.show()
        collections?.removeAllObjects()
        HttpUnit.HttpGet(url: JYUrl.history()) { (responseObject, success) in
            if success {
                let books:AnyObject = responseObject.object(forKey: "data") as AnyObject
                if books.isKind(of: NSArray.self) {
                    let bookCollections = books as! NSArray
                    for item in bookCollections {
                        self.collections?.add(JYCollection.init(dict: item as! [String : AnyObject]))
                    }
                    self.closeBookrackEmptyRecommend(UIButton())
                }
                self.collectionview.reloadData()
            }
            JYProgressHUD.dismiss()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.collections?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collect:JYCollection = self.collections?.object(at: indexPath.row) as! JYCollection
        return BookrackBooksCell.createCell(collectionView: collectionView, indexPath: indexPath, collect: collect, colsure: { (collection) in
            let detail = BookDetailController.create()
            detail.id = collection.id
            self.navigationController?.pushViewController(detail, animated: true)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}




















