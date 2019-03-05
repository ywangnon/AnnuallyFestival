//
//  AboutDate.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 24/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import Foundation

class AboutDate {
    private let now = Date()
    
    private let date = DateFormatter()
    
    public func getDate() -> String {
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST")
        date.dateFormat = "yyyyMMdd"
        
        let strKRTime = date.string(from: now)
        
        return strKRTime
    }
}
