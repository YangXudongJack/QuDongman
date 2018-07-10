//
//  JYAllCatelogView.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/7.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYAllCatelogView: UIView, UITableViewDelegate, UITableViewDataSource {

    var tablewview:UITableView?
    
    var catelogColsure:((JYCatelog)->Void)?
    
    var _catelogs:Array<Any>?
    var catelogs:Array<Any> {
        set {
            _catelogs = newValue
            self.addSubview(JYCatelogHeader.showCatelogHeader(title: "", serial: (_catelogs?.count)!, colsure: {
                self.removeFromSuperview()
            }))
            
            tablewview?.reloadData()
        }
        
        get {
            return _catelogs!
        }
    }
    
    class func showAllCatelog(catelogs:Array<Any>, colsure:@escaping (JYCatelog)->Void) -> Void {
        let catelogView = JYAllCatelogView(frame: UIScreen.main.bounds)
        catelogView.catelogs = catelogs
        catelogView.catelogColsure = colsure
        UIApplication.shared.keyWindow?.addSubview(catelogView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.boardColor().withAlphaComponent(0.9)
        var originY:Int = 93
        if DeviceManager.isIphoneX() {
            originY = 113
        }
        let size = UIScreen.main.bounds.size
        tablewview = UITableView(frame: CGRect(x: 0, y: 113, width: Int(size.width), height: Int(size.height) - originY), style: .plain)
        tablewview?.tableFooterView = UIView()
        tablewview?.separatorStyle = .none
        tablewview?.delegate = self
        tablewview?.dataSource = self
        tablewview?.backgroundColor = UIColor.clear
        self.addSubview(tablewview!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _catelogs!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let catelog:JYCatelog = _catelogs![indexPath.row] as! JYCatelog
        let vip:Bool = (catelog.is_vip! as NSString).boolValue
        return JYCatelogItemCell.showCatelogItem(tableview: tableView, title: catelog.name!, vip: vip)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let catelog:JYCatelog = _catelogs![indexPath.row] as! JYCatelog
        catelogColsure!(catelog)
    }
}
