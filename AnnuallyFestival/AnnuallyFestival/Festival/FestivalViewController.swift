//
//  ViewController.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 08/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class FestivalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {
    
    @IBOutlet var festivalTableView: UITableView!
    
    var festivals = [Festival]()
    var festivalInfo = Festival.init(title: "", startDate: "", endDate: "", tel: nil, img: nil, sumImg: nil, addr: nil, detailAddr: nil)
    
    var currentElement = ""
    
    var festivalsDB: Results<DBFestival>!
    
    func requestFestivalInfo() {
        let date = AboutDate()
        let now = date.getDate()
        
        let url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=oiCg9z40WmbiqKsEGTX7QtlqOR3Gl5VAd8uL%2BpcQTi4W4cmvaV00haG5iTzTkNn%2BXLYUkjsYo%2FYld0Ktz%2FFwoQ%3D%3D&MobileOS=IOS&MobileApp=AnnuallyFestival&arrange=D&eventStartDate=" + now
        
        guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
        
        xmlParser.delegate = self
        xmlParser.parse()
        
        print("Realm DB: ", Realm.Configuration.defaultConfiguration.fileURL!)
        
        print("request parse")
    }
    
    // MARK: - table setting
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return festivalsDB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.festivalTableView.dequeueReusableCell(withIdentifier: "FestivalCell", for: indexPath) as! FestivalCell
        
        cell.festivalTitle.text = festivalsDB[indexPath.row].title
        cell.festivalDate.text = festivalsDB[indexPath.row].startDate + "~" + festivalsDB[indexPath.row].endDate
        if let imgString = festivalsDB[indexPath.row].sumImg,
            let url = URL(string: imgString),
            let imgData = try? Data(contentsOf: url) {
            cell.festivalIMG.image = UIImage(data: imgData)
        }
        cell.follow.isSelected = festivalsDB[indexPath.row].follow 
        cell.follow.tag = indexPath.row
        cell.follow.addTarget(self, action: #selector(followButtonAction(_:)), for: .touchUpInside)
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setFestivals()
        festivalTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        festivalTableView.delegate = self
        festivalTableView.dataSource = self
        
        requestFestivalInfo()
    }
    
    // MARK: - xml Parsing
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if(elementName == "item") {
            festivalInfo = Festival.init(title: "",
                                         startDate: "",
                                         endDate: "",
                                         tel: nil,
                                         img: nil,
                                         sumImg: nil,
                                         addr: nil,
                                         detailAddr: nil)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        // 필수
        case "title": festivalInfo.title = string
        case "eventstartdate": festivalInfo.startDate = string
        case "eventenddate": festivalInfo.endDate = string
        // 옵션
        case "tel": festivalInfo.tel = string
        case "firstimage": festivalInfo.img = string
        case "firstimage2": festivalInfo.sumImg = string
        case "addr1": festivalInfo.addr = string
        case "addr2": festivalInfo.detailAddr = string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "item") {
//            festivals.append(festivalInfo)
            
            do {
                let realm = try Realm()
                
                let festival = DBFestival(//seq,
                                          festivalInfo.title,
                                          festivalInfo.startDate,
                                          festivalInfo.endDate,
                                          festivalInfo.tel,
                                          festivalInfo.img,
                                          festivalInfo.sumImg,
                                          festivalInfo.addr,
                                          festivalInfo.detailAddr,
                                          false)
                
                let festivalss = realm.objects(DBFestival.self)
                var test = false
                for festivalone in festivalss {
                    if festival.title == festivalone.title {
                        test = true
                    }
                }
                if !test {
                    try realm.write {
                        print(festival)
                        realm.add(festival, update: true)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func setFestivals() {
        do {
            let realm = try Realm()
            self.festivalsDB = realm.objects(DBFestival.self).sorted(byKeyPath: "startDate")
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FestivalViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailView = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! FestivalDetailViewController
        detailView.navigationItem.title = festivalsDB[indexPath.row].title
        
        detailView.festivalImg = festivalsDB[indexPath.row].sumImg
        detailView.festivalDate = festivalsDB[indexPath.row].startDate + " ~ " + festivalsDB[indexPath.row].endDate
        detailView.festivalTel = festivalsDB[indexPath.row].tel
        detailView.festivalAddr = festivalsDB[indexPath.row].addr
        detailView.festivalDetail = festivalsDB[indexPath.row].detailAddr
        
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

extension FestivalViewController {
    @objc func followButtonAction(_ sender: UIButton) {
        
        let contentView = sender.superview
        let cell = contentView?.superview as! FestivalCell
        let title = cell.festivalTitle.text!
        
        if sender.isSelected {
//            followFestivals.append(festivals[sender.tag])
            do {
                let realm = try Realm()
                
                let festival = realm.object(ofType: DBFestival.self, forPrimaryKey: title)!
                
                try realm.write {
                    festival.follow = true
                    
                    realm.add(festival, update: true)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
//            followFestivals = followFestivals.filter { $0.title != festivals[sender.tag].title}
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
    }
}
