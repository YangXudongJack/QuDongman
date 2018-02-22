//
//  UIColor+RGB.swift
//  QuDongman
//
//  Created by 杨旭东 on 27/10/2017.
//  Copyright © 2017 JackYang. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    private func color(tone:Int, alpha:CGFloat) -> UIColor{
        return UIColor.init(red:CGFloat(((tone & 0xFF0000) >> 16))/255.0, green:CGFloat(((tone & 0xFF00) >> 8))/255.0, blue:CGFloat((tone & 0xFF))/255.0, alpha: alpha)
    }
    
    public class func NavigationColor() -> UIColor {
        return self.init().color(tone: 0xfa9950, alpha: 1.0)
    }
    
    public class func AboutBackgroundColor() -> UIColor {
        return self.init().color(tone: 0xf7f7f7, alpha: 1.0)
    }
    
    public class func titleColor_Blue() -> UIColor {
        return self.init().color(tone: 0x50acfa, alpha: 1.0)
    }
    
    public class func messageColor() -> UIColor {
        return self.init().color(tone: 0xb1b1b1, alpha: 1.0)
    }
    
    public class func beginColor() -> UIColor {
        return self.init().color(tone: 0xf3d2a9, alpha: 1.0)
    }
    
    public class func endColor() -> UIColor {
        return self.init().color(tone: 0xfa9950, alpha: 1.0)
    }
    
    public class func borderColor() -> UIColor {
        return self.init().color(tone: 0xfcdcb3, alpha: 1.0)
    }
}