//
//  CharacterDetailTableViewController.swift
//  WorldOfMarvel
//
//  Created by vm mac on 2017-04-24.
//  Copyright © 2017 Michael Aubie. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CharacterDetailTableViewController: UITableViewController {

    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterDescriptionLabel: UITextView!
    
    @IBOutlet weak var numberOfEventsLabel: UILabel!
    
    var currentCharacter: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterNameLabel.text = currentCharacter._name
        characterDescriptionLabel.isEditable = false
        characterDescriptionLabel.text = currentCharacter._description
        characterImage.image = currentCharacter._thumbnailImage
        print(currentCharacter._description)
        downloadPicture()
        numberOfEventsLabel.text = "\(currentCharacter.eventList.count)"
    }
    
    
    func downloadPicture() {
        Alamofire.request(currentCharacter._thumbnail, method: .get).responseImage { response in
            guard let image:Image = response.result.value else {
                // Handle error
                return
            }
            // Do stuff with your image
            if let imageData = UIImageJPEGRepresentation(image, 1) {
                self.characterImage.image = UIImage(data: imageData)!
            }
        }
    }


    @IBAction func backBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 4) {
            print("clicked on 4")
            performSegue(withIdentifier: "eventsSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "eventsSegue") {
            let navVC = segue.destination as! UINavigationController
            let eventsVC = navVC.topViewController as! AllEventsTableViewController
            
            eventsVC.eventList = currentCharacter.eventList
        }
    }
    

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
