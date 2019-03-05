//
//  FestivalCell.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 10/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import UIKit

class FestivalCell: UITableViewCell  {
    
    @IBOutlet var festivalIMG: UIImageView!
    
    @IBOutlet var festivalTitle: UILabel!
    @IBOutlet var festivalDate: UILabel!
    
    @IBOutlet var follow: UIButton!
    
    var delegate: sendFollowFestivalData?
    
    @objc func toggleSelection() {
        follow.isSelected = !follow.isSelected
        if follow.isSelected == true {
            print(follow.isSelected)
            delegate?.followfestival(cell: self)
            print("pass")
//            myFollowFestivals.set([Festival](), forKey: key)
        } else {
            print(follow.isSelected)
        }
        
        print("<FollowList>")
        
        if let confirmDataArray: [Festival] = myFollowFestivals.object(forKey: key) as! [Festival] {
            let readData = confirmDataArray
            for festival in readData {
                print(festival.title + " * ")
            }
        } else {
            print("follow is nothing!")
        }
        
        if myFollowFestivals.object(forKey: key) as! [Festival] == nil {
            print("!!!")
        }
    }
    
//    @IBAction func FollowSelection(_ sender: UIButton) {
//        follow.isSelected = !follow.isSelected
//        if follow.isSelected == true {
//            print(follow.isSelected)
////            print(festivalTitle.text!)
////            print(festivalDate.text!)
//            sender.imageView?.image = #imageLiteral(resourceName: "full heart")
//            let contentView = sender.superview
//            let cell = contentView?.superview as! FestivalCell
//            delegate?.followfestival(cell: cell)
//        } else {
//            print(follow.isSelected)
//            sender.imageView?.image = #imageLiteral(resourceName: "empty heart")
//            let contentView = sender.superview
//            let cell = contentView?.superview as! FestivalCell
//            delegate?.followfestival(cell: cell)
//            print("pass")
//        }
//        print("follow list")
//
//        if let confirmDataArray: [Festival] = myFollowFestivals.object(forKey: key) as! [Festival] {
//            let readData = confirmDataArray
//            for festival in readData {
//                print(festival.title + " * ")
//            }
//        } else {
//            print("follow is nothing!")
//        }
//
//        if myFollowFestivals.object(forKey: key) as! [Festival] == nil {
//            print("!!!")
//        }
//    }

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
