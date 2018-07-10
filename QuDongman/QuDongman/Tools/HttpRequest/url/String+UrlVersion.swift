//
//  String+UrlVersion.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/7.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import Foundation

extension String {
    func to_v(v:String) -> String {
        return self.replacingOccurrences(of: "v2_1", with: v)
    }
}










