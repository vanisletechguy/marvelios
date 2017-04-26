//
//  EventItemTableViewController.swift
//  WorldOfMarvel
//
//  Created by vm mac on 2017-04-25.
//  Copyright © 2017 Michael Aubie. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class EventItemTableViewController: UITableViewController {

    var eventURL = ""
    
    
    
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    
    @IBOutlet weak var eventDescription: UITextView!
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    var imageURL = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(eventURL)
        print(getEventURL(url: eventURL))
        downloadEventInfo()
    }
    
    func downloadEventInfo() {
    
        let fullURL = URL(string: getEventURL(url: eventURL))!
        Character.downloadEventData(downloadURL: fullURL) { response in
            self.eventTitleLabel.text = response[0].0
            self.eventDescription.text = response[0].1
            self.imageURL = response[0].2
            self.downloadPicture()
        }
    }
    
    
    func downloadPicture() {
        Alamofire.request(imageURL!, method: .get).responseImage { response in
            guard let image:Image = response.result.value else {
                // Handle error
                return
            }
            // Do stuff with your image
            if let imageData = UIImageJPEGRepresentation(image, 1) {
                self.eventImageView.image = UIImage(data: imageData)!
            }
        }
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
