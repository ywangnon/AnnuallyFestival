//
//  DBModel.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 14/03/2019.
//  Copyright © 2019 hansub yoo. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class DBFestival: Object {
    // 필수 정보
//    dynamic var seq: Int = 0
    dynamic var title: String = ""
    dynamic var startDate: String = ""
    dynamic var endDate: String = ""
    dynamic var follow: Bool = false
    
    // 옵션 정보, nil 가능
    dynamic var tel: String?
    dynamic var img: String?
    dynamic var sumImg: String?
    dynamic var addr: String?
    dynamic var detailAddr: String?
    
    convenience init(//_ seq: Int,
                     _ title: String,
                     _ startDate: String,
                     _ endDate: String,
                     _ tel: String? = nil,
                     _ img: String? = nil,
                     _ sumImg: String? = nil,
                     _ address: String? = nil,
                     _ detailAddress: String? = nil,
                     _ follow: Bool = false) {
        self.init()
        
//        self.seq = seq
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.tel = tel
        self.img = img
        self.sumImg = sumImg
        self.addr = address
        self.detailAddr = detailAddress
        self.follow = follow
    }
    
    override class func primaryKey() -> String? {
        return "title"
    }
}
