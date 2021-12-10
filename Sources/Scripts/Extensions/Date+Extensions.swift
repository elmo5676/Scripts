// ********************** File *********************************
// * Copyright © 4BitCrew, LLC - All Rights Reserved
// * Created on 12/10/21, for 
// * Matthew Elmore <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** File *********************************


import Foundation

public extension Date {
    
    private static var df: DateFormatter = {
        let df = DateFormatter()
        return df
    }()
    
    func dateToString(ofFormat: DateFormat) -> String {
        Date.df.dateFormat = ofFormat.value
        Date.df.timeZone = TimeZone(abbreviation: "UTC")
        return Date.df.string(from: self)
    }
    
    func modify(_ component:  Calendar.Component, by: Int) -> Date? {
        Calendar.current.date(byAdding: component, value: by, to: self)
    }

}
