//
//  JYChapterBuyController.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/29.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit
import Alamofire

class JYChapterBuyController: UIViewController {

    @IBOutlet weak var chapterTitleLabel: UILabel!
    
    @IBOutlet weak var chapterPriceLabel: UILabel!
    
    @IBOutlet weak var userBalanceLabel: UILabel!
    
    var price:String?
    var chapterTitle:String?
    var userBalance:String?
    var bookId:String?
    var chapterId:String?
    
    var dismissColsure:(()->Void)?
    
    class func showChapterBuyView(title:String, price:String, balance:String, colsure:@escaping ()->Void) -> JYChapterBuyController{
        let chapter:JYChapterBuyController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JYChapterBuyController") as! JYChapterBuyController
        chapter.chapterTitle = title
        chapter.userBalance = "我的余额：\(balance)币"
        chapter.price = price
        chapter.dismissColsure = colsure
        return chapter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chapterTitleLabel.text = chapterTitle
        userBalanceLabel.text = userBalance
        
        let priceDic = [NSAttributedStringKey.foregroundColor : UIColor.titleColor_Blue(), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 32.0)]
        let normaloDic = [NSAttributedStringKey.foregroundColor : UIColor.normalPriceInfo(), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13.0)]
        let string:NSString = "本话需要\(price!)币" as NSString
        let priceRange:NSRange = string.range(of: price!)
        let attribute:NSMutableAttributedString = NSMutableAttributedString(string: string as String, attributes: normaloDic)
        attribute.addAttributes(priceDic, range: priceRange as NSRange)
        chapterPriceLabel.attributedText = attribute
    }

    @IBAction func payForChapter(_ sender: UIButton) {
        JYProgressHUD.show()
        
        var params:Parameters = Parameters.init()
        params["btype"] = "11"
        params["book_id"] = bookId
        params["chapter_id"] = chapterId
        HttpUnit.HttpPost(url: JYUrl.buyChapter(), params: params) { (response, success) in
            JYProgressHUD.dismiss()
            if success {
                let result:String = response.object(forKey: "code") as! String
                
                if Int(result) == 0 {
                    JYProgressHUD.showFailed(failed: "购买失败")
                }else if Int(result) == 1 {
                    JYProgressHUD.showSuccess(success: "购买成功")
                }else if Int(result) == 42211 {
                    JYProgressHUD.showFailed(failed: "余额不足")
                }
            }
        }
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismissColsure!()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

















