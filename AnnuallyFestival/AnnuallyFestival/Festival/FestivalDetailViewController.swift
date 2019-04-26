//
//  FestivalDetailViewController.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 12/03/2019.
//  Copyright © 2019 hansub yoo. All rights reserved.
//

import UIKit

class FestivalDetailViewController: UIViewController {

    var festivalName = String()
    var festivalImg: String?
    var festivalDate = String()
    var festivalTel: String?
    var festivalAddr: String?
    var festivalDetail: String?
    
//    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var festivalImgView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
//    @IBOutlet weak var detailAddrLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.titleLabel.text = self.festivalName
        
        if let imgString = festivalImg,
            let url = URL(string: imgString),
            let imgData = try? Data(contentsOf: url) {
            self.festivalImgView.image = UIImage(data: imgData)
        }
        
        self.dateLabel.text = festivalDate
        self.telLabel.text = festivalTel
        
        if let addr = festivalAddr {
            if let detail = festivalDetail {
                self.addressLabel.text = "" + addr + detail
            } else {
                self.addressLabel.text = "" + addr
            }
        }
        
//        self.detailAddrLabel.text = festivalDetail
    }
}
