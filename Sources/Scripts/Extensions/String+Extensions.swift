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
    
    
    // MARK: - 🔅 Getting SubString Range
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    
    subscript(r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    subscript(r: CountableClosedRange<Int>) -> String {
        let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }
    
    func substring(fromIndex: Int, toIndex: Int) -> String? {
        if fromIndex < toIndex && toIndex < self.count /*use string.characters.count for swift3*/{
            let startIndex = self.index(self.startIndex, offsetBy: fromIndex)
            let endIndex = self.index(self.startIndex, offsetBy: toIndex)
            return String(self[startIndex..<endIndex])
        } else {
            return nil
        }
    }
    
}
