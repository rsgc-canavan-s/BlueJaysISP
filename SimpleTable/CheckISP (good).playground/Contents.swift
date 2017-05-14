//: Playground - noun: a place where people can play

import UIKit

var arrayOfGameData : [String] = []
var seeingIfThisShitWorks = ["I swear to the lord if this doesnt work...", "I thought I was gonna have to end it all", "Thank goodness it works"]

func scoresPresses(_ sender: Any) {
    // I want to click this button, and transition to a table, where the scores of past games and the dates of future games are loaded
    
    var numberOfGameData : Int = 0
    
    
    // holds all of the data that I will parse
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
    
    // declaring variables that I will use
    var jaysRuns : Int = 0
    var oppRuns : Int = 0
    var outcome : String = ""
    var jaysRunsString : String = ""
    var oppRunsString : String = ""
    var outcomeScore : String = ""
    var winningTeam : String = ""
    var winningPitcherName : String = ""
    var losingPitcherName : String = ""
    var jaysName : String = ""
    var oppName : String = ""
    
    // getJSON
    //
    // Purpose: Open a JSON file included in the playground Resources folder and return the contents of the file as JSON data
    func parseMyJSON(_ JSON : Data) {
        
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
                // this was a test to see if I was able to parse correctly
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
                
                // making a string of the winning and losing pitchers so I can print them
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
                        // setting the Jays name (I know it's not necessary but hey)
                        jaysName = homeTeamName
                        // Setting the opponents name
                        oppName = awayTeamName
                        // getting the runs scored as strings with the winner correctly defined
                        jaysRunsString = homeTeamRuns
                        oppRunsString = awayTeamRuns
                    } else {
                        // changing the runs scored to integers
                        jaysRuns = awayRunsAsInt
                        oppRuns = homeRunsAsInt
                        // setting the Jays name (I know it's not necessary but hey)
                        jaysName = awayTeamName
                        // setting the opponents name
                        oppName = homeTeamName
                        // getting the runs scored as strings with the winner correctly defined
                        jaysRunsString = awayTeamRuns
                        oppRunsString = homeTeamRuns
                    }
                    
                    var gameScore : String = ("Jays" + jaysRunsString + "Opposition" + oppRunsString)
                    
                    arrayOfGameData.append(gameScore)
                    
                    if jaysRuns - oppRuns > 0 {
                        outcome = "won"
                        outcomeScore = (jaysRunsString + " to " + oppRunsString)
                    } else {
                        outcome = "lost"
                        outcomeScore = (oppRunsString + " to " + jaysRunsString)
                    }
                    print("Today the Blue Jays played at " + stadium)
                    print("The Toronto Blue Jays scored " + jaysRunsString + " runs")
                    print("The " + awayTeamName + " scored " + oppRunsString)
                    print("So, the Jays " + outcome + ", the outcome being " + outcomeScore)
                    print("The winning pitcher was " + winningPitcherName + " and the losing pitcher was " + losingPitcherName)
                }
                
                // here we are going to attach the data that we parsed to the array to it can be read and printed to the app
                arrayOfGameData.append("" + outcome +  " " + jaysName + "" + jaysRunsString + " vs. " + oppName + "" + oppRunsString)
                print(arrayOfGameData)
            }
            
            
            // Now iterate over the list of Any objects and try to cast each object to a dictionary
            
        }  catch let error as NSError {
            
            print ("Failed to load: \(error.localizedDescription)")
            
        }
        
    }
    
    func getMyJSON() {
        
        var actualURL : String = ""
        
        let startOfURL = "http://gd2.mlb.com/components/game/mlb/year_"
        
        let today = Date()
        
        let todayString = today.description
        
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
        
        actualURL = ((startOfURL) + (year) + "/month_" + (month) +  "/day_" + (day) + "/master_scoreboard.json")
        
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
                            
                            // Parse the retrieved data
                            parseMyJSON(d)
                            
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
    }
}