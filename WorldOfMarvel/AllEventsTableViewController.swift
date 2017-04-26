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
    var selectedEvent = 0
    
    
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = indexPath.row
        performSegue(withIdentifier: "Event Item Segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        let eventVC = navVC.topViewController as! EventItemTableViewController
        
        eventVC.eventURL = eventList[selectedEvent].1
    }

    @IBAction func backBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
