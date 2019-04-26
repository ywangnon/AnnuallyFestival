//
//  FestivalCell.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 10/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import UIKit

class FestivalCell: UITableViewCell  {

    var festivalName = String()
    var festivalStartDate = String()
    var festivalEndDate = String()
    var festivalTel: String?
    var festivalIMGString: String?
    var festivalSumIMGString: String?
    var festivalAddress: String?
    var festivalDetailAddress: String?
    
    @IBOutlet var festivalIMG: UIImageView!
    
    @IBOutlet var festivalTitle: UILabel!
    @IBOutlet var festivalDate: UILabel!
    
    @IBOutlet var follow: UIButton!
    
    @objc func toggleSelection() {
        follow.isSelected = !follow.isSelected
        print("follow: \(follow.isSelected)")
//        let festival = Festival.init(title: self.festivalName,
//                                     startDate: self.festivalStartDate,
//                                     endDate: self.festivalEndDate,
//                                     tel: self.festivalTel,
//                                     img: self.festivalIMGString,
//                                     sumImg: self.festivalSumIMGString,
//                                     addr: self.festivalAddress,
//                                     detailAddr: self.festivalDetailAddress)
//        if follow.isSelected {
//            followFestivals.append(festival)
//        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        follow.setImage(#imageLiteral(resourceName: "empty heart"), for: .normal)
        follow.setImage(#imageLiteral(resourceName: "full heart"), for: .selected)
        follow.addTarget(self, action: #selector(toggleSelection), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
