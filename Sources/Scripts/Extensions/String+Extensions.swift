// ********************** File *********************************
// * Copyright © 4BitCrew, LLC - All Rights Reserved
// * Created on 12/10/21, for 
// * Matthew Elmore <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** File *********************************


import Foundation

public extension String {
    
    func getLastSeperatedBy(_ by: String) -> String {
        let resultArr = self.components(separatedBy: by)
        if resultArr.count > 0 {
            return resultArr.last!
        } else {
            return "UnKnown"
        }
    }
    
    func split(_ by: String) -> [String] { self.components(separatedBy: by) }
    
    ///This translates Dates from various API's into Date()
    func getDateFrom(ofType: DateFormat) -> Date? {
        let df = DateFormatter()
        df.dateFormat = ofType.value
        df.timeZone = TimeZone(abbreviation: "UTC")
        switch ofType {
        case .reference:
            let refDate = "19700101000000"
            return df.date(from: refDate)
        default:
            return df.date(from: self)
        }}

    ///This translates Dates from various API's into Date()
    func getDateFrom(str: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = str
        df.timeZone = TimeZone(abbreviation: "UTC")
        return df.date(from: self)
    }
    
    var trimmed: String {
        self.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    
}
