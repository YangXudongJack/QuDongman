//
//  BookrackViewController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/5/24.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class BookrackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var statuebarBackgroundHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectviewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bookrackEmptyHeaderConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectButton: UIButton!
    
    @IBOutlet weak var historyButton: UIButton!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func collectAction(_ sender: UIButton) {
        collectButton.isSelected = true
        historyButton.isSelected = false
    }
    
    @IBAction func historyAction(_ sender: UIButton) {
        collectButton.isSelected = false
        historyButton.isSelected = true
    }
    
    @IBAction func closeBookrackEmptyRecommend(_ sender: UIButton) {
        let size = UIScreen.main.bounds.size
        bookrackEmptyHeaderConstraint.constant = 0
        collectviewHeightConstraint.constant = size.height - UIApplication.shared.statusBarFrame.size.height - 44 - 50 - (DeviceManager.isIphoneX() ?20:0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:BookrackBooksCell! = collectionView.dequeueReusableCell(withReuseIdentifier: BookrackBooksCell.identifier, for: indexPath) as! BookrackBooksCell;
        if cell == nil {
            cell = Bundle.main.loadNibNamed("BookrackBooksCell", owner: nil, options: nil)?.first as! BookrackBooksCell
        }
        return cell
    }
    
    
}




















