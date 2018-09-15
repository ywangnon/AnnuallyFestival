//
//  api.swift
//  AnuallyFestival
//
//  Created by Hansub Yoo on 2018. 8. 31..
//  Copyright © 2018년 hansub yoo. All rights reserved.
//

import Foundation

enum API {
    static let baseURL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?"
    static let serviceKey = API.baseURL + "serviceKey=oiCg9z40WmbiqKsEGTX7QtlqOR3Gl5VAd8uL%2BpcQTi4W4cmvaV00haG5iTzTkNn%2BXLYUkjsYo%2FYld0Ktz%2FFwoQ%3D%3D"
    
    enum necessaryInfo {
        static let ncInfo = API.serviceKey + "&MobileOS=IOS&MobileApp=AnuallyFestival"
    }
}
