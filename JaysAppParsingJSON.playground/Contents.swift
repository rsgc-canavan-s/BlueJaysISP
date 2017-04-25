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

struct JaysDataList {
    var homeTeamName : String
    var awayTeamName : String
    var startTime : String
    var location : String
    var stadium : String
    var homeTeamRuns : String
    var awayTeamRuns : String
    var losingPitcherName : String
    var winningPitcherName : String
}
var jaysRuns : Int = 0
var oppRuns : Int = 0
var outcome : String = ""
var jaysRunsString : String = ""
var oppRunsString : String = ""
var outcomeScore : String = ""
var winningTeam : String = ""
var winningPitcherName : String = ""
var losingPitcherName : String = ""
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
    
    var parsedData : [JaysDataList] = []
    
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
            
            // iterating through each of the games in the total array of games
            guard let aGame = game as? [String : Any]  else {
                return
            }
            
            // getting the home team's name
            guard let homeTeamName = aGame["home_team_name"] as? String else {
                print("Could not get the home team name")
                return
            }
            
            // getting the away team's name
            guard let awayTeamName = aGame["away_team_name"] as? String else {
                print("Could not get the home team name")
                return
            }
            
            // making sure that these guard let statements are successful
            //print(awayTeamName + " at " + homeTeamName)
            
            // gets the start time of each game
            guard let startTime = aGame["time"] as? String else {
                print("Could not get start time")
                return
            }
            
            // gets the location of each game
            guard let location = aGame["location"] as? String else {
                print("Could not get location")
                return
            }
            
            //gets the stadium name
            guard let stadium = aGame["venue"] as? String else {
                print("Could not find the stadium")
                return
            }
            
            // iterates through each games "linescore," which contains the runs scored from each team
            //print(aGame["linescore"])
            
            guard let runsScored = aGame["linescore"] as? [String : Any] else {
                print("Could not get the runs scored")
                return
            }
            
            // iterating through the "r" array which is the runs scored by each team
            guard let runs = runsScored["r"] as? [String: String] else {
                print("Could not get the runs")
                return
            }
            
            // geting the home team runs
            guard let homeTeamRuns = runs["home"] as String! else {
                print("Can't get the home team runs")
                return
            }
            
            // getting the away team runs
            guard let awayTeamRuns = runs["away"] as String! else {
                print("Can't get the away team runs")
                return
            }
            // iterate over the losing pitcher array
            guard let losingPitcher = aGame["losing_pitcher"] as? [String: Any] else {
                print("Could not get the losing pitcher")
                return
            }
            // get the pitcher's last name
            guard let lastNameLP = losingPitcher["last"] as? String else {
                print("Could not get losing pitcher's last name")
                return
            }
            // get the pitcher's first name
            guard let firstNameLP = losingPitcher["first"] as? String else {
                print("Could not get losing pitcher's first name")
                return
            }
            // iterating over the winning pitcher array
            guard let winningPitcher = aGame["winning_pitcher"] as? [String: Any] else {
                print("Could not het winning pitcher's data")
                return
            }
            // getting the winning pitcher's last name
            guard let lastNameWP = winningPitcher["last"] as? String else {
                print("Could not get winning pitcher's last name")
                return
            }
            // getting the winning pitcher's first name
            guard let firstNameWP = winningPitcher["first"] as? String else {
                print("Could not get winning pitcher's first name")
                return
            }
            
            winningPitcherName = (firstNameWP + " " + lastNameWP)
            losingPitcherName = (firstNameLP + " " + lastNameLP)
            
            // appending all of the collected data to "parsedData"
            if homeTeamName == ("Blue Jays") || awayTeamName == ("Blue Jays"){
                
                print("We've found it!")
                
                parsedData.append(JaysDataList(homeTeamName: homeTeamName, awayTeamName: awayTeamName, startTime: startTime, location: location, stadium: stadium, homeTeamRuns: homeTeamRuns, awayTeamRuns: awayTeamRuns, losingPitcherName: (firstNameLP+lastNameLP), winningPitcherName: (firstNameWP+lastNameWP)))

                
                //switching the runs scored by each team to an integer
                let homeRunsAsInt : Int = Int(homeTeamRuns)!
                let awayRunsAsInt : Int = Int(awayTeamRuns)!
                
                // figuring out if the Jays were at home or away
                if homeTeamName == "Blue Jays" {
                    // changing the runs scored to integers
                    jaysRuns = homeRunsAsInt
                    oppRuns = awayRunsAsInt
                    // getting the runs scored as strings with the winner correctly defined
                    jaysRunsString = homeTeamRuns
                    oppRunsString = awayTeamRuns
                } else {
                    // changing the runs scored to integers
                    jaysRuns = awayRunsAsInt
                    oppRuns = homeRunsAsInt
                    // getting the runs scored as strings with the winner correctly defined
                    jaysRunsString = awayTeamRuns
                    oppRunsString = homeTeamRuns
                }

                
                if jaysRuns - oppRuns > 0 {
                    outcome = "won 😀"
                    outcomeScore = (jaysRunsString + " to " + oppRunsString)
                } else {
                    outcome = "sadly lost"
                    outcomeScore = (oppRunsString + " to " + jaysRunsString)
                }
                print("Today the Blue Jays played at " + stadium)
                print("The Toronto Blue Jays scored " + jaysRunsString + " runs")
                print("The " + awayTeamName + " scored " + oppRunsString)
                print("So, the Jays " + outcome + ", the outcome being " + outcomeScore)
                print("The winning pitcher was " + winningPitcherName + " and the losing pitcher was " + losingPitcherName)
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
    /*
     if let gameData = parse(json) {
     print(gameData)
     }
     */
    
    
    
} else {
    
    // Error
    print("Could not get JSON data from the file.")
}
