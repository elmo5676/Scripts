// ********************** File *********************************
// * Copyright © 4BitCrew, LLC - All Rights Reserved
// * Created on 12/10/21, for 
// * Matthew Elmore <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** File *********************************


import SwiftUI

public extension String {
    func listMatches(for pattern: String) -> [String] {
      guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
        return []
      }
        
      
      let range = NSRange(self.startIndex..., in: self)
      let matches = regex.matches(in: self, options: [], range: range)
      
      return matches.map {
        let range = Range($0.range, in: self)!
        return String(self[range])
      }
    }
    
    func getFirstMatch(for pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        
        let range = NSRange(self.startIndex..., in: self)
        let matches = regex.matches(in: self, options: [], range: range)
        
        var result: [String] = matches.map {
            let range = Range($0.range, in: self)!
            return String(self[range])
        }
        
        return result[0]
    }
    
    func replaceMatches(for pattern: String, with replacementString: String) -> String? {
      guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
        return self
      }
      
      let range = NSRange(self.startIndex..., in: self)
      return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacementString)
    }
    
    func containsMatch(of pattern: String) -> Bool {
      guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
        return false
      }
      let range = NSRange(self.startIndex..., in: self)
      return regex.firstMatch(in: self, options: [], range: range) != nil
    }
    
    func listGroups(for pattern: String, inString string: String) -> [String] {
      guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
        return []
      }
      
      let range = NSRange(self.startIndex..., in: self)
      let matches = regex.matches(in: self, options: [], range: range)
      
      var groupMatches: [String] = []
      for match in matches {
        let numberOfRangesInMatch = match.numberOfRanges
        
        for rangeIndex in 1..<numberOfRangesInMatch {
          let range = match.range(at: rangeIndex);
          if range.location != NSNotFound {
            if let rangeInString = Range(range, in: self) {
              groupMatches.append(String(self[rangeInString]))
            }
          }
        }
      }
      
      return groupMatches
    }
    
    func highlightMatches(for pattern: String) -> NSAttributedString {
      guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
        return NSMutableAttributedString(string: self)
      }
      
      let range = NSRange(self.startIndex..., in: self)
      let matches = regex.matches(in: self, options: [], range: range)
      
      let attributedText = NSMutableAttributedString(string: self)
      
      for match in matches {
        attributedText.addAttribute(.backgroundColor, value: Color.yellow, range: match.range)
      }
      
      return attributedText.copy() as! NSAttributedString
    }
}
