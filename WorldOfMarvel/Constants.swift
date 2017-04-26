//
//  Constants.swift
//  WorldOfMarvel
//
//  Created by vm mac on 2017-04-24.
//  Copyright © 2017 Michael Aubie. All rights reserved.
//

import Foundation


let baseURL = "https://gateway.marvel.com:443/v1/public/"
let APIKEY = "d331da6eb1dccfc20c013db05af8fc8d"
let APP_ID = "&apikey="
let TIME_STAMP = "ts=1"
let HASH_URL = "&hash="
let MY_HASH = "7afe95c07a3405af0b83ee17e8439eda"
let CHARACTER_LIMIT = "&limit=100"
let CHARACTERS_START_WITH = "&nameStartsWith="
let CHARACTERS_A = "&nameStartsWith=a"

typealias DownloadComplete = ([Character]) -> ()
typealias EventDownloadComplete = ([(String,String,URL)]) -> ()

let CHARACTERS_URL = "\(baseURL)characters?\(TIME_STAMP)\(CHARACTER_LIMIT)\(CHARACTERS_A)\(APP_ID)\(APIKEY)\(HASH_URL)\(MY_HASH)"

//let CHARACTERS_BY_LETTER_URL = "\(baseURL)characters?\(TIME_STAMP)\(CHARACTER_LIMIT)\(CHARACTERS_START_WITH)a\(APP_ID)\(APIKEY)\(HASH_URL)\(MY_HASH)"


//let EVENTS_URL = "http://gateway.marvel.com/v1/public/events/255"

public func getEventURL(url:String) -> String {
    let eventURL = "\(url)?\(TIME_STAMP)\(APP_ID)\(APIKEY)\(HASH_URL)\(MY_HASH)"
    
    return eventURL
}


let CHARACTERS_BY_LETTER_FIRST = "\(baseURL)characters?\(TIME_STAMP)\(CHARACTER_LIMIT)\(CHARACTERS_START_WITH)"
let CHARACTERS_BY_LETTER_LAST = "\(APP_ID)\(APIKEY)\(HASH_URL)\(MY_HASH)"
