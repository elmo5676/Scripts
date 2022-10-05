// ********************** Utilities *********************************
// * Copyright © 4BitCrew, LLC - All Rights Reserved
// * Created on 7/25/22, for Scripts
// * Matthew Elmore <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** Utilities *********************************


import Foundation

public struct Utilities {
    
    public static func runPackage(_ forSeconds: Double) {
        RunLoop.main.run(until: Date(timeIntervalSinceNow: forSeconds))
    }
    
    public static func doTry(_ closure: () throws -> Void) {
        do {
            try closure()
        } catch {
            print(error)
        }
    }
}


