//
//  Characters.swift
//  WorldOfMarvel
//
//  Created by vm mac on 2017-04-24.
//  Copyright © 2017 Michael Aubie. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class Character {
    var _id: Int
    var _name: String
    var _description: String
    var _thumbnail: String
    var _numberOfComics: Int     //comics[available]
    var _numberOfSeries: Int     //series[available]
    var _numberOfStories: Int    //stories[available]
    var _thumbnailImage: UIImage
    
    var eventList: [(String,String)] = [] ///// NAME, URI
    
    init (id:Int, name:String, description:String) {
        _id = id
        _name = name
        _description = description
        _thumbnail = ""
        _numberOfStories = 0
        _numberOfSeries = 0
        _numberOfComics = 0
        _thumbnailImage = UIImage()
    }
    init(id:Int, name:String, description:String, thumbnail:String, numberOfComics:Int, numberOfSeries:Int, numberOfStories:Int) {
        _id = id
        _name = name
        _description = description
        _thumbnail = thumbnail
        _thumbnailImage = UIImage() //empty image
        _numberOfComics = numberOfComics
        _numberOfSeries = numberOfSeries
        _numberOfStories = numberOfStories
        
    }
    
    
    static func downloadCharacterData(downloadURL: URL, completed: @escaping DownloadComplete) {
        
        var characterList = [Character]() // clear the list
        var totalCharacters = 0
        var tmpName = ""
        var tmpID = 0
        var tmpDescription = ""
        var tmpImage = UIImage()
        var tmpThumbURL = ""
        
//        var tmpThumbnail = ""
//        var tmpNumberOfComics = 0
//        var tmpNumberOfSeries = 0
//        var tmpNumberOfStories = 0
        
        //let charactersURL = URL(string: CHARACTERS_URL)!
        
        print(downloadURL)
        Alamofire.request(downloadURL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let data = dict["data"] as? Dictionary<String, AnyObject> {
                    //get count
                    if let count = data["count"] as? Int {
                        totalCharacters = count
                        print(totalCharacters)
                        if let results = data["results"] as? [Dictionary<String, AnyObject>] {
                            
                            for result in results {
                                if let name = result["name"] as? String {
                                    tmpName = name
                                }
                                if let id = result["id"] as? Int {
                                    tmpID = id
                                }
                                if let description = result["description"] as? String {
                                    tmpDescription = description
                                } else {
                                    tmpDescription = ""
                                }
                                
                                if let thumbnail = result["thumbnail"] as? Dictionary<String, AnyObject> {
                                    if let thumbPath = thumbnail["path"] as? String {
                                        let fullThumbPath = "\(thumbPath).jpg"
                                        //let thumbURL = URL(string: fullThumbPath)!
                                        //print(thumbURL)
                                        tmpThumbURL = fullThumbPath
                                        
                                    }
                                }
                                
                                var eventList: [(String,String)] = []
                                var tmpeventName = ""
                                var tmpeventURI = ""
                                if let comicEvents = result["events"] as? Dictionary<String, AnyObject> {
                                    if let eventItems = comicEvents["items"] as? [Dictionary<String, AnyObject>] {
                                        for eventItem in eventItems {
                                            if let eventName = eventItem["name"] as? String {
                                                tmpeventName = eventName
                                            }
                                            if let resourceURI = eventItem["resourceURI"] as? String {
                                                tmpeventURI = resourceURI
                                            }
                                            eventList.append((tmpeventName, tmpeventURI))
                                        }
                                    }
                                }
                                
                                //print("\(tmpID) \(tmpName) \(tmpDescription)")
                                let newCharacter = Character(id: tmpID, name: tmpName, description: tmpDescription)
                                newCharacter._thumbnailImage = tmpImage
                                newCharacter._thumbnail = tmpThumbURL
                                newCharacter.eventList = eventList
                                characterList.append(newCharacter)
                                
                                
                                tmpID = 0
                                tmpName = ""
                                tmpDescription = ""
                                
                                
                            }
                        }
                    }
                }
            }
            completed(characterList)
        }
        
    }
    
    
    
    static func downloadEventData(downloadURL: URL, completed: @escaping EventDownloadComplete) {
    
        var eventName = ""
        var eventDescription = ""
        var eventThumbnailURL = ""
        var fullThumbURL = URL(string: "")
        
        var eventList: [(String,String,URL)] = []
        print("TLTLTLT")
        Alamofire.request(downloadURL).responseJSON { response in
            let result = response.result
            print("AAA###C")
            if let dict = result.value as? Dictionary<String, AnyObject> {
                print("AA$$$$")
                if let data = dict["data"] as? Dictionary<String, AnyObject> {
                    print("AAABBBCC")
                    if let dataResults = data["results"] as? [Dictionary<String, AnyObject>] {
                        print("A%%%%%")
                        for object in dataResults {
                            if let title = object["title"] as? String {
                                eventName = title
                            }
                            if let description = object["description"] as? String {
                                eventDescription = description
                            }
                            if let thumbnail = object["thumbnail"] as? Dictionary<String, AnyObject> {
                                if let thumbPath = thumbnail["path"] as? String {
                                    eventThumbnailURL = thumbPath
                                    fullThumbURL = URL(string: "\(thumbPath).jpg")!
                                    print("AAABBBCC")
                                    print(fullThumbURL)
                                }
                            }
                            
                            eventList.append((eventName,eventDescription,fullThumbURL!))
                            
                        }
                    }
                }
            }
            
            
            completed(eventList)
        }
        
    }
}







/*
 {
 "id": 1011334,
 "name": "3-D Man",
 "description": "",
 "modified": "2014-04-29T14:18:17-0400",
 "thumbnail": {
 "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
 "extension": "jpg"
 },
 "resourceURI": "http://gateway.marvel.com/v1/public/characters/1011334",
 "comics": {
 "available": 11,
 "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/comics",
 "items": [
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/21366",
 "name": "Avengers: The Initiative (2007) #14"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/24571",
 "name": "Avengers: The Initiative (2007) #14 (SPOTLIGHT VARIANT)"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/21546",
 "name": "Avengers: The Initiative (2007) #15"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/21741",
 "name": "Avengers: The Initiative (2007) #16"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/21975",
 "name": "Avengers: The Initiative (2007) #17"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/22299",
 "name": "Avengers: The Initiative (2007) #18"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/22300",
 "name": "Avengers: The Initiative (2007) #18 (ZOMBIE VARIANT)"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/22506",
 "name": "Avengers: The Initiative (2007) #19"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/10223",
 "name": "Marvel Premiere (1972) #35"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/10224",
 "name": "Marvel Premiere (1972) #36"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/10225",
 "name": "Marvel Premiere (1972) #37"
 }
 ],
 "returned": 11
 },
 "series": {
 "available": 2,
 "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/series",
 "items": [
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/series/1945",
 "name": "Avengers: The Initiative (2007 - 2010)"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/series/2045",
 "name": "Marvel Premiere (1972 - 1981)"
 }
 ],
 "returned": 2
 },
 "stories": {
 "available": 21,
 "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/stories",
 "items": [
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/19947",
 "name": "Cover #19947",
 "type": "cover"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/19948",
 "name": "The 3-D Man!",
 "type": "interiorStory"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/19949",
 "name": "Cover #19949",
 "type": "cover"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/19950",
 "name": "The Devil's Music!",
 "type": "interiorStory"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/19951",
 "name": "Cover #19951",
 "type": "cover"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/19952",
 "name": "Code-Name:  The Cold Warrior!",
 "type": "interiorStory"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/47184",
 "name": "AVENGERS: THE INITIATIVE (2007) #14",
 "type": "cover"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/47185",
 "name": "Avengers: The Initiative (2007) #14 - Int",
 "type": "interiorStory"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/47498",
 "name": "AVENGERS: THE INITIATIVE (2007) #15",
 "type": "cover"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/47499",
 "name": "Avengers: The Initiative (2007) #15 - Int",
 "type": "interiorStory"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/47792",
 "name": "AVENGERS: THE INITIATIVE (2007) #16",
 "type": "cover"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/47793",
 "name": "Avengers: The Initiative (2007) #16 - Int",
 "type": "interiorStory"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/48361",
 "name": "AVENGERS: THE INITIATIVE (2007) #17",
 "type": "cover"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/48362",
 "name": "Avengers: The Initiative (2007) #17 - Int",
 "type": "interiorStory"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/49103",
 "name": "AVENGERS: THE INITIATIVE (2007) #18",
 "type": "cover"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/49104",
 "name": "Avengers: The Initiative (2007) #18 - Int",
 "type": "interiorStory"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/49106",
 "name": "Avengers: The Initiative (2007) #18, Zombie Variant - Int",
 "type": "interiorStory"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/49888",
 "name": "AVENGERS: THE INITIATIVE (2007) #19",
 "type": "cover"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/49889",
 "name": "Avengers: The Initiative (2007) #19 - Int",
 "type": "interiorStory"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/54371",
 "name": "Avengers: The Initiative (2007) #14, Spotlight Variant - Int",
 "type": "interiorStory"
 }
 ],
 "returned": 20
 },
 "events": {
 "available": 1,
 "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/events",
 "items": [
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/events/269",
 "name": "Secret Invasion"
 }
 ],
 "returned": 1
 },
 "urls": [
 {
 "type": "detail",
 "url": "http://marvel.com/characters/74/3-d_man?utm_campaign=apiRef&utm_source=d331da6eb1dccfc20c013db05af8fc8d"
 },
 {
 "type": "wiki",
 "url": "http://marvel.com/universe/3-D_Man_(Chandler)?utm_campaign=apiRef&utm_source=d331da6eb1dccfc20c013db05af8fc8d"
 },
 {
 "type": "comiclink",
 "url": "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=d331da6eb1dccfc20c013db05af8fc8d"
 }
 ]
 },
 */
