//: Playground - noun: a place where people can play

import UIKit

//let actualURL = "http://gd2.mlb.com/components/game/mlb/year_2017/month_04/day_28/master_scoreboard.json"
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

actualURL = ("http://gd2.mlb.com/components/game/mlb/year_" + (year) + "/month_" + (month) +  "/day_" + (day) + "/master_scoreboard.json")
