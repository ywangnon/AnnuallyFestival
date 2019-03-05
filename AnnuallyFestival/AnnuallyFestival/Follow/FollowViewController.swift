//
//  FollowViewController.swift
//  AnnuallyFestival
//
//  Created by Hansub Yoo on 08/10/2018.
//  Copyright © 2018 hansub yoo. All rights reserved.
//

import UIKit

class FollowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var followTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.followTable.dequeueReusableCell(withIdentifier: "FestivalFollowCell", for: indexPath) as! FestivalCell
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
