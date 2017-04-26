//
//  AllEventsTableViewController.swift
//  WorldOfMarvel
//
//  Created by vm mac on 2017-04-25.
//  Copyright © 2017 Michael Aubie. All rights reserved.
//

import UIKit

class AllEventsTableViewController: UITableViewController {

    var eventList: [(String,String)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event cell", for: indexPath)

        cell.textLabel?.text = eventList[indexPath.row].0
        
        print(eventList[indexPath.row].1)
        return cell
    }
    

    @IBAction func backBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
