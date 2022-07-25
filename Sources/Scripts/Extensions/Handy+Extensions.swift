// ********************** Handy+Extensions *********************************
// * Copyright © 4bitCrew, LLC - All Rights Reserved
// * Created on 3/31/20, for DAFIF_NEW_CLI
// * Matthew Elmore <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** Handy+Extensions *********************************

import Foundation

//MARK: - String Array Extensions
public extension Sequence where Iterator.Element == URL {

    var getAllFilesInSubDirs: [URL] {
        var files: [URL] = []
        self.forEach { u in
            if #available(OSX 10.11, *) {
                guard u.hasDirectoryPath else { return files.append(u.resolvingSymlinksInPath()) }
            } else {
                // Fallback on earlier versions
            }
            guard let dir = FileManager.default.enumerator(at: u.resolvingSymlinksInPath(), includingPropertiesForKeys: nil) else { return }
            for case let url as URL in dir {
                files.append(url.resolvingSymlinksInPath())
            }
        }
        return files
    }
}


public extension Array where Element == String {
    
    func removeCarriageReturn() -> [String] {
        var result: [String] = []
        for i in self {
            if i.contains("\n") {
                result.append(i.replacingOccurrences(of: "\n", with: ""))
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
public extension String {

    func replaceFirst(_ number: Int, with: String) -> String {
        let range = self.index(self.startIndex, offsetBy: number)
        return self.replacingCharacters(in: self.startIndex..<range, with: with)
    }

    func iterateAndReplaceOccurences(of: String, inString: String) -> String {
        var result = inString
        
        let ind = self.indices(of: of)
        var number = 1
        
        for _ in 0..<ind.count {
            let tempStr = result
            guard let range = tempStr.range(of: of) else { continue }
            result = tempStr.replacingCharacters(in: range, with: "\(number)")
            number += 1
        }
        return result
    }
    
    func indices(of: String) -> [Int] {
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

    func ranges(of: String) -> [Range<String.Index>] {
        let _indices = indices(of: of)
        let count = of.count
        return _indices.map({ index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: $0+count) })
    }


    func camelCased(with separator: Character) -> String {
        return self.lowercased()
            .split(separator: separator)
            .enumerated()
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
            .joined()
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    func capitalizeFirstLetter_() -> String {
        return self.capitalizingFirstLetter()
    }
    
    func lowerCaseFirstLetter() -> String {
        return self.prefix(1).lowercased() + dropFirst()
    }

    func removeAllCharOf(_ str: String) -> String {
        let charR = Character(str)
        var returnCharecters: [Character] = []
        for char in self {
            if char != charR {
                returnCharecters.append(char)
            }}
        return String(returnCharecters)
    }

    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }

    func subString(_ from: Int, offsetBy: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(startIndex, offsetBy: offsetBy)
        return String(self[startIndex...endIndex])
    }

}

public extension Optional where Wrapped == Any {
    
    var toDouble: Double {
        switch self {
        case .some(let val):
            let newVal = val as? Double
            if let newValDouble = newVal {
                return newValDouble
            } else {
                return 0.0
            }
        case .none:
            return 0
        }
    }
    
    var toString: String {
        switch self {
        case .some(let val):
            return val as! String
        case .none:
            return ""
        }
    }
}
