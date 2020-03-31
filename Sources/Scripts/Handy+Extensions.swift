//
// ********************** Handy+Extensions *********************************
// * Copyright © 4bitCrew, LLC - All Rights Reserved
// * Created on 3/31/20, for DAFIF_NEW_CLI
// * Matthew Elmore <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** Handy+Extensions *********************************

import Foundation

//MARK: - String Array Extensions
extension Array where Element == String {
    
    public func removeCarriageReturn() -> [String] {
        var result: [String] = []
        for i in self {
            if i.contains("\r") {
                result.append(i.replacingOccurrences(of: "\r", with: ""))
            } else if i.contains("\n") {
                result.append(i.replacingOccurrences(of: "\n", with: ""))
            }else {
                result.append(i)
            }
        }
        return result
    }
}

//MARK: - String Extensions
extension String {

    public func replaceFirst(_ number: Int, with: String) -> String {
        let range = self.index(self.startIndex, offsetBy: number)
        return self.replacingCharacters(in: self.startIndex..<range, with: with)
    }

    
    public func indices(of: String) -> [Int] {
        var indices = [Int]()
        var position = startIndex
        while let range = range(of: of, range: position..<endIndex) {
            let i = distance(from: startIndex,
                             to: range.lowerBound)
            indices.append(i)
            let offset = of.distance(from: of.startIndex,
                                             to: of.endIndex) - 1
            guard let after = index(range.lowerBound,
                                    offsetBy: offset,
                                    limitedBy: endIndex) else {
                                        break
            }
            position = index(after: after)
        }
        return indices
    }

    public func ranges(of: String) -> [Range<String.Index>] {
        let _indices = indices(of: of)
        let count = of.count
        return _indices.map({ index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: $0+count) })
    }


    public func camelCased(with separator: Character) -> String {
        return self.lowercased()
            .split(separator: separator)
            .enumerated()
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
            .joined()
    }

    public func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating public func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    public func lowerCaseFirstLetter() -> String {
        return self.prefix(1).lowercased() + dropFirst()
    }

    public func removeAllCharOf(_ str: String) -> String {
        let charR = Character(str)
        var returnCharecters: [Character] = []
        for char in self {
            if char != charR {
                returnCharecters.append(char)
            }}
        return String(returnCharecters)
    }

    public func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }

    public func subString(_ from: Int, offsetBy: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(startIndex, offsetBy: offsetBy)
        return String(self[startIndex...endIndex])
    }

}
