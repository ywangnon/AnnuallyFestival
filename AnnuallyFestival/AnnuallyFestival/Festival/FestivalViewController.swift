//
//  ViewController.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 08/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import UIKit
import Alamofire

class FestivalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate, sendFollowFestivalData {
    
    func sendData(data: Festival) {
        print("save Data")
        var readData: [Festival] = []
        if let confirmDataArray: [Festival] = myFollowFestivals.object(forKey: key) as? [Festival] {
            readData = confirmDataArray
        }
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
        print("<testData>")
        
//        print(encodedData)
        readData.append(data)
        myFollowFestivals.set(readData, forKey: key)
    }
    
    @IBOutlet var festivalTableView: UITableView!
    
    var festivals = [Festival]()
    var festivalInfo = Festival.init(title: "", startDate: "", endDate: "", tel: nil, img: nil, sumImg: nil, addr: nil, detailAddr: nil)
    
    var currentElement = ""
    
    func requestFestivalInfo() {
        let date = AboutDate()
        let now = date.getDate()
        
        let url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=oiCg9z40WmbiqKsEGTX7QtlqOR3Gl5VAd8uL%2BpcQTi4W4cmvaV00haG5iTzTkNn%2BXLYUkjsYo%2FYld0Ktz%2FFwoQ%3D%3D&MobileOS=IOS&MobileApp=AnnuallyFestival&arrange=D&eventStartDate=" + now
        
        guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
        
        xmlParser.delegate = self
        xmlParser.parse()
        
        print("request parse")
    }
    
    // MARK: - table setting
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return festivals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.festivalTableView.dequeueReusableCell(withIdentifier: "FestivalCell", for: indexPath) as! FestivalCell
        cell.delegate = self
        cell.festivalTitle.text = festivals[indexPath.row].title
        cell.festivalDate.text = festivals[indexPath.row].startDate + " ~ " + festivals[indexPath.row].endDate
        
        if festivals[indexPath.row].sumImg != nil {
            let url = URL(string: festivals[indexPath.row].sumImg!)
            if let imageData = try? Data(contentsOf: url!, options: []) {
                cell.festivalIMG.image = UIImage(data: imageData)
            }
        }
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        festivalTableView.delegate = self
        festivalTableView.dataSource = self
        
        requestFestivalInfo()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - xml Parsing
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if(elementName == "item") {
            festivalInfo = Festival.init(title: "", startDate: "", endDate: "", tel: nil, img: nil, sumImg: nil, addr: nil, detailAddr: nil)
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
            festivals.append(festivalInfo)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func followfestival(cell: FestivalCell) {
//        let contentview = sender.superview
//        let cell = contentview?.superview as! FestivalCell
        print("delegate func")
        let index = festivalTableView.indexPath(for: cell)?.row
        print("index.row is \(index)")
        
        let addFollowFestival = festivals[index!]
        print("followed festival is \(addFollowFestival.title)")
        
        sendData(data: addFollowFestival)
    }
}
