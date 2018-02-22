//
//  DeviceManager.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class DeviceManager: NSObject {
    func model() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
                
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    class func scaleW() -> CGFloat {
        let width = UIScreen.main.bounds.size.width
        return (width/375.0)
    }
    
    class func scaleH() -> CGFloat {
        let height = UIScreen.main.bounds.size.height
        return (height/667.0)
    }
    
    class func simulator4(model:String) -> Bool {
        switch model {
        case "i386", "x86_64":
            let frame = UIScreen.main.bounds
            if frame.size.width == 320 && frame.size.height == 480 {
                return true
            }else{
                return false
            }
            
        default:
            return false
        }
    }
    
    class func simulator5(model:String) -> Bool {
        switch model {
        case "i386", "x86_64":
            let frame = UIScreen.main.bounds
            if frame.size.width == 320 && frame.size.height == 568 {
                return true
            }else{
                return false
            }
            
        default:
            return false
        }
    }
    
    class func isIphone4() -> Bool {
        let model = DeviceManager().model()
        if model.contains("iPhone3")||model.contains("iPhone4") {
            return true
        }else {
            return (false || self.simulator4(model: model))
        }
    }
    
    class func isIphone5() -> Bool {
        let model = DeviceManager().model()
        if model.contains("iPhone5")||model.contains("iPhone6") {
            return true
        }else {
            return (false || self.simulator5(model: model))
        }
    }
    
    class func isIphoneSE() -> Bool {
        let model = DeviceManager().model()
        if model=="iPhone8,4" {
            return true
        }else {
            return (false || self.simulator5(model: model))
        }
    }
}
