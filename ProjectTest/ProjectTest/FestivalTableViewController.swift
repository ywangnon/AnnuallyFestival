//
//  FestivalTableViewController.swift
//  ProjectTest
//
//  Created by Hansub Yoo on 17/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import UIKit

class FestivalTableViewController: UITableViewController, XMLParserDelegate {

    var xmlParser = XMLParser()
    
    var currentElement = ""
    
    var festivals = [[String: String]]()
    var festival = [String: String]()
    
    var festivalName = ""
    var festivalDate = ""
    
    func requestFestivalInfo() {
        let url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=oiCg9z40WmbiqKsEGTX7QtlqOR3Gl5VAd8uL%2BpcQTi4W4cmvaV00haG5iTzTkNn%2BXLYUkjsYo%2FYld0Ktz%2FFwoQ%3D%3D&MobileOS=IOS&MobileApp=AnnuallyFestival&arrange=A&listYN=Y&eventStartDate=20180101"
        
        guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
        
        xmlParser.delegate = self
        xmlParser.parse()
        
        print("request parse")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestFestivalInfo()
        print("Festival start")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if (elementName == "item") {
            festival = [:]
            festivalName = ""
            festivalDate = ""
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "item") {
            festival["title"] = festivalName
            festival["date"] = festivalDate
            
            print(festivalName)
            print(festivalDate)
            
            festivals.append(festival)
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": festivalName = string
        case "eventenddate": festivalDate = string
        default: break
        }
        
//        if currentElement == "title" {
//            festivalName = string
//        } else if currentElement == "eventenddate" {
//            festivalDate = string
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("\(festivals.count)")
        return festivals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "festivalCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = festivals[indexPath.row]["title"]
        print(festivals[indexPath.row]["title"])

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
