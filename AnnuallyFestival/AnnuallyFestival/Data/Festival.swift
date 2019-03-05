//
//  Festival.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 11/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import Foundation

//let key = "saveFollowData"

struct Festival {
    // 필수 정보
    var title: String
    var startDate: String
    var endDate: String

    // 옵션 정보
    // nil 가능
    var tel: String?
    var img: String?
    var sumImg: String?
    var addr: String?
    var detailAddr: String?
}


