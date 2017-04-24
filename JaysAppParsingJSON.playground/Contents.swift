//: Playground - noun: a place where people can play

import UIKit

/*:
 
 # Parsing JSON From a Local File
 
 "This JSON dataset identifies public locations and cooling centres in the City of Toronto that offer an air-conditioned space for temporary relief on heat alert and extreme heat alert days."
 
 [Source](http://www1.toronto.ca/wps/portal/contentonly?vgnextoid=e7356d1900531510VgnVCM10000071d60f89RCRD&vgnextchannel=1a66e03bb8d1e310VgnVCM10000071d60f89RCRD)
 
 ## Your goal
 
 The code below loads a JSON file contained within this playground.
 
 Use optional binding (with *if let* statements or *guard let* statements inside a function) to parse the raw JSON data into Swift-native data structures.
 
 A good first step is to examine the data contained inside the file, and by hand, make a plan for what Swift-native data types you will parse the data into.
 
 Then, write the code to do the parsing.
 
 */

import Foundation

struct jaysDataList {
    var homeTeamName : String
    var awayTeamName : String
    var startTime : Double
    var location : String
    var homeTeamRuns : Int
    var awayTeamRuns : Int
}

// getJSON
//
// Purpose: Open a JSON file included in the playground Resources folder and return the contents of the file as JSON data
func getJSON(forResource resource : String, ofType type : String) -> Data? {
    
    
    // Obtain the path to file in the playground bundle
    guard let path = Bundle.main.path(forResource: resource, ofType: type) else {
        
        // Early exit from function with error
        print("File path not found.")
        return nil
        
    }
    
    // Read the raw data in the file
    guard let data = FileManager.default.contents(atPath: path) else {
        
        // Early exit from function with error
        print("Could not read data from file.")
        return nil
    }
    
    // Return the JSON data
    return data
    
}

// CoolingCentre
//
// Purpose: Store information we care about from the JSON file.


// parseJSON
//
// Purpose: Parse a String containing JSON data and return a Swift-native data structure containing relevant data
func parse(_ JSON : Data) {
    
    // Create an empty array of the structure that will contain data about a cooling centre
    
    // Begin parsing the cooling centre data
    // De-serializing JSON can throw errors, so should be inside a do-catch structure
    do { // able to handle errors that can be "thrown", it "catches" the errors
        
        // Get the raw list of JSON objects as an array of Any objects
        // "try" tells the code that there can be an error "thrown"
        let gameData = try JSONSerialization.jsonObject(with: JSON, options: JSONSerialization.ReadingOptions.allowFragments) as! Any // allows for there to be any data type (int, string, array, etc.)
        
        // Cast into the top-level dictionary containing all data
        guard let generalData = gameData as? [String : Any] else{
            return
        }
        
        // Cast into the lower level getting just "data" data
        guard let specificData = generalData["data"] as? [String : Any] else {
            return
        }
        
        //print(specificData["games"])
        
        //getting games object
        guard let gamesData = specificData["games"] as? Any else{
            print("could not get array of games")
            return
        }
        
        // getting the data for each game
        guard let specificGamesData = gamesData as? [String : Any] else{
            print("could not get specific games data")
            return
        }
        
        //cast the value of the game key to get the array
        guard let games = specificGamesData["game"] as? [Any] else {
            print("could not get array of games")
            return
        }
        /*
         struct jaysDataList {
         var homeTeamName : String
         var awayTeamName : String
         var startTime : Double
         var location : String
         var finalScore : Double
         }
         */
        
        // Now iterate over each game
        for game in games {
            
            guard let aGame = game as? [String : Any]  else {
                return
            }
            print(aGame["home_team_name"])
            
            var homeTeamName: String = String(describing: aGame["home_team_name"])
            var awayTeamName: String = String(describing: aGame["away_team_name"])
            
            if homeTeamName == ("Blue Jays") || awayTeamName == ("Blue Jays"){
                print("We've found it!")
                guard let homeTeamName = aGame["home_team_name"] as? String else {
                    print("Could not get the Home team's name")
                    return
                }
                
                guard let awayTeamName = aGame["away_team_name"] as? String else {
                    print("Could not get away team name")
                    return
                }
                
                guard let startTime = aGame["time"] as? Double else {
                    print("Could not get start time")
                    return
                }
                
                guard let runsScored = aGame["r"] as? [String : Int] else {
                    print("Could not get the runs scored")
                    return
                }
                var homeTeamRuns: Int = Int(runsScored["home"]!)
                var awayTeamRuns: Int = Int(runsScored["away"]!)
            }
        }
        
        
        // Now iterate over the list of Any objects and try to cast each object to a dictionary
        
    }  catch let error as NSError {
        
        print ("Failed to load: \(error.localizedDescription)")
        
    }
    
}

// Attempt to get the JSON data from the file
if let json = getJSON(forResource: "gameData", ofType: "json") {
    
    // Now parse the JSON into Swift-native data structures...
    parse(json)
    
} else {
    
    // Error
    print("Could not get JSON data from the file.")
}
