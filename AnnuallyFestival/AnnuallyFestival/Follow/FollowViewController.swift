//
//  FollowViewController.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 08/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import UIKit
import RealmSwift

class FollowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var followTable: UITableView!
    
    var followFestivalDB: Results<DBFestival>!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followFestivalDB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.followTable.dequeueReusableCell(withIdentifier: "FestivalFollowCell", for: indexPath) as! FestivalCell
        
//        cell.festivalName = followFestivals[indexPath.row].title
//        cell.festivalStartDate = followFestivals[indexPath.row].startDate
//        cell.festivalEndDate = followFestivals[indexPath.row].endDate
//        cell.festivalIMGString = followFestivals[indexPath.row].img
//        cell.festivalSumIMGString = followFestivals[indexPath.row].sumImg
//        cell.festivalTel = followFestivals[indexPath.row].tel
//        cell.festivalAddress = followFestivals[indexPath.row].addr
//        cell.festivalDetailAddress = followFestivals[indexPath.row].detailAddr
        
        cell.festivalTitle.text = followFestivalDB[indexPath.row].title
        cell.festivalDate.text = followFestivalDB[indexPath.row].startDate + " ~ " + followFestivalDB[indexPath.row].endDate
        if let imgString = followFestivalDB[indexPath.row].sumImg,
            let url = URL(string: imgString),
            let imgData = try? Data(contentsOf: url) {
            cell.festivalIMG.image = UIImage(data: imgData)
        }
        cell.follow.isSelected = followFestivalDB[indexPath.row].follow 
        cell.follow.tag = indexPath.row
        cell.follow.addTarget(self, action: #selector(followButtonAction(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailView = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! FestivalDetailViewController
        detailView.navigationItem.title = followFestivalDB[indexPath.row].title

        detailView.festivalImg = followFestivalDB[indexPath.row].sumImg
        detailView.festivalDate = followFestivalDB[indexPath.row].startDate + " ~ " + followFestivalDB[indexPath.row].endDate
        detailView.festivalTel = followFestivalDB[indexPath.row].tel
        detailView.festivalAddr = followFestivalDB[indexPath.row].addr
        detailView.festivalDetail = followFestivalDB[indexPath.row].detailAddr
        
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.followTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        followTable.delegate = self
        followTable.dataSource = self
        
        setFollows()
    }
    
    func setFollows() {
        do {
            let realm = try Realm()
//            self.followFestivalDB = realm.objects(DBFestival.self)
            self.followFestivalDB = realm.objects(DBFestival.self).filter("follow = true").sorted(byKeyPath: "startDate")
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func followButtonAction(_ sender: UIButton) {
        print("\n---------- [ action ] ----------\n")
        
        
        let contentView = sender.superview
        let cell = contentView?.superview as! FestivalCell
        let title = cell.festivalTitle.text!
        
        
        if sender.isSelected {
            
        } else {
//            followFestivals = followFestivals.filter { $0.title != followFestivals[sender.tag].title}
            
            do {
                let realm = try Realm()
                
                let festival = realm.object(ofType: DBFestival.self, forPrimaryKey: title)!
                
                try realm.write {
                    festival.follow = false
                    realm.add(festival, update: true)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        self.followTable.reloadData()
    }
}
