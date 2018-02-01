//
//  Extensions.swift
//  Pods Updater
//
//  Created by Kizito Nwose on 30/01/2018.
//  Copyright © 2018 Kizito Nwose. All rights reserved.
//

import Cocoa


// MARK: - NSTableView
extension NSTableView {
    func registerCellNib(_ cellClass: AnyClass,
                                              forIdentifier identifier: NSUserInterfaceItemIdentifier) {
        let nibName = String.className(cellClass)
        let nib = NSNib(nibNamed: NSNib.Name(rawValue: nibName), bundle: nil)
        self.register(nib, forIdentifier: identifier)
    }
}

// MARK: String
extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}

extension String {
    func trimmingWhiteSpaces() -> String {
        return trimmingCharacters(in: .whitespaces)
    }
    
    func splitByNewLines() -> [String] {
        return components(separatedBy: .newlines)
    }
    
    func splitByComma() -> [String] {
        return components(separatedBy: ",")
    }
}

extension String {
    var isValidPodLine: Bool {
        return self.starts(with: "pod")
    }
    
    var isValidPodVersionInfo: Bool {
        let trimmed = self.trimmingWhiteSpaces()
        if let firstCharecter = trimmed.first {
            return ["~","=",">","<"].contains(firstCharecter)
        }
        return false
    }
}

extension String {
    func replacingFirstOccurrence(of string: String, with replacement: String) -> String {
        if let range = range(of: string) {
            return replacingCharacters(in: range, with: replacement)
        }
        return String(self)
    }
    
    func findMatches(forRegex regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch {
            print("Regex error: \(error)")
            return []
        }
    }
}

extension String {
    func startIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}


// MARK:- Array
extension Array {
    var second: Element? {
        if count > 1 {
            return self[1]
        }
        return nil
    }
    
    var third: Element? {
        if count > 2 {
            return self[2]
        }
        return nil
    }
    
    var fourth: Element? {
        if count > 3 {
            return self[3]
        }
        return nil
    }
}

extension Array where Element == String {
    func joinByNewLines() -> String {
        return self.joined(separator: "\n")
    }
}

// MARK:- Collection
extension Collection {
    var isNotEmpty: Bool {
        return count > 0
    }
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// MARK:- Bool
extension Bool {
    func not() -> Bool {
        return !self
    }
}

// MARK:- Character
extension Character {
    var isDigit: Bool {
        if let scalar = unicodeScalars.first {
            return CharacterSet.decimalDigits.contains(scalar)
        }
        return false
    }
}


