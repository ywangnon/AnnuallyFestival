//
//  FestivalFollowCell.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 29/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import UIKit

class FestivalFollowCell: UITableViewCell {
    
    @IBOutlet var festivalIMG: UIImageView!
    
    @IBOutlet var festivalTitle: UILabel!
    @IBOutlet var festivalDate: UILabel!
    
    @IBOutlet var follow: UIButton!
    
    @objc func toggleSelection() {
        follow.isSelected = !follow.isSelected
        if follow.isSelected == true {
            print(follow.isSelected)
            print(festivalTitle.text!)
            print(festivalDate.text!)
        } else {
            print(follow.isSelected)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        follow.setImage(#imageLiteral(resourceName: "empty heart"), for: .normal)
        follow.setImage(#imageLiteral(resourceName: "full heart"), for: .selected)
        follow.addTarget(self, action: #selector(toggleSelection), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
