//: Playground - noun: a place where people can play

import UIKit
/*
//let actualURL = "http://gd2.mlb.com/components/game/mlb/year_2017/month_04/day_28/master_scoreboard.json"
var actualURL : String = ""

let startOfURL = "http://gd2.mlb.com/components/game/mlb/year_"

let today = Date()

let todayString = today.description

var todayInt : Int = 0

var yesterdayInt : Int = 0

var yesterdayString : String = ""

// Explode based on a deliminer of " "
let todayStringParts = todayString.components(separatedBy: " ")

var year : String = ""
var month : String = ""
var day : String = ""
if let todayStartingSeperated = todayStringParts.first {
    
    // explode the first element of the array based on "-"
    let components = todayStartingSeperated.components(separatedBy: "-")
    year = components[0]
    month = components[1]
    day = components[2]
}

todayInt = Int(day)!

yesterdayInt = todayInt - 1

yesterdayString = String(yesterdayInt)

actualURL = ("http://gd2.mlb.com/components/game/mlb/year_" + (year) + "/month_" + (month) +  "/day_" + (yesterdayString) + "/master_scoreboard.json")
print(actualURL)
*/
var actualURL : String = ""

let startOfURL = "http://gd2.mlb.com/components/game/mlb/year_"

let today = Date()

let todayString = today.description

var todayInt : Int = 0

var yesterdayInt : Int = 0

var yesterdayString : String = ""

// Explode based on a deliminer of " "
let todayStringParts = todayString.components(separatedBy: " ")

var year : String = ""
var month : String = ""
var day : String = ""
if let todayStartingSeperated = todayStringParts.first {
    
    // explode the first element of the array based on "-"
    let components = todayStartingSeperated.components(separatedBy: "-")
    year = components[0]
    month = components[1]
    day = components[2]
}

todayInt = Int(day)!

yesterdayInt = todayInt - 1

yesterdayString = String(yesterdayInt)

actualURL = ("" + (startOfURL) + (year) + "/month_" + (month) +  "/day_" + (yesterdayString) + "/master_scoreboard.json")

// Define a URL to retrieve a JSON file from
let address : String = actualURL

// Try to make a URL request object
if let url = URL(string: address) {
    
    // We have an valid URL to work with
    print(url)
    
    // Now we create a URL request object
    let urlRequest = URLRequest(url: url)
    
    // Now we need to create an NSURLSession object to send the request to the server
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    // Now we create the data task and specify the completion handler
    let task = session.dataTask(with: urlRequest) {
        (data, response, error) in
        
        // Cast the NSURLResponse object into an NSHTTPURLResponse objecct
        if let r = response as? HTTPURLResponse {
            
            // If the request was successful, parse the given data
            if r.statusCode == 200 {
                
                if let d = data {
                    
                    print(d)
                }
                
            }
            
        }
    }
    // Finally, we tell the task to start (despite the fact that the method is named "resume")
    task.resume()
    
} else {
    
    // The NSURL object could not be created
    print("Error: Cannot create the NSURL object.")
    
}