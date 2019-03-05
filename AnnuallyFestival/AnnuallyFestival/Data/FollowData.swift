//
//  FollowData.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 31/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import Foundation

var myFollowFestivals = UserDefaults.standard
let key = "FollowFestival"

protocol sendFollowFestivalData {
    func followfestival(cell: FestivalCell)
}
