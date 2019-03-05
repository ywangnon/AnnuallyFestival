//
//  TableViewController.swift
//  ProjectTest
//
//  Created by Hansub Yoo on 17/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, XMLParserDelegate {
    
    var xmlParser = XMLParser()
    
    var currentElemet = ""
    var movieItems = [[String: String]]()
    var movieItem = [String: String]()
    
    var pubTitle = ""
    var contents = ""
    
    func requestMovieInfo() {
        let url = "http://api.koreafilm.or.kr/openapi-data2/service/api105/getOpenDataList"
        
        guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
        
        xmlParser.delegate = self
        xmlParser.parse()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        requestMovieInfo()
    }
    
    // XML 파서가 시작 테그를 만나면 호출됨
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElemet = elementName
        
        // 시작이므로 요소들을 초기화
        if (elementName == "item") {
            movieItem = [String : String]()
            pubTitle = ""
            contents = ""
        }
    }
    
    // XML 파서가 종료 테그를 만나면 호출됨
    // 그 구간안의 전체적인 요소들을 기억하는 것으로 추측됨
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "item") {
            movieItem["title"] = pubTitle
            movieItem["contents"] = contents
            
            movieItems.append(movieItem)
        }
    }
    
    // 현재 테그에 담겨있는 문자열 전달
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (currentElemet == "contents") {
            contents = string
        } else if (currentElemet == "pubtitle") {
            pubTitle = string
        }
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
        return self.movieItems.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = movieItems[indexPath.row]["title"]
        
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
