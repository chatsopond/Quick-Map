//
//  CitySession.swift
//  Quick Map
//
//  Created by Chatsopon Deepateep on 11/6/2565 BE.
//

import Foundation
import Combine
import os

/// Load and filter the city from alphabetical ordered files
///
/// The original file will be sorted by alphabet and seperated/grouped by first prefix.
/// Instead of loading all list to the memory, this function will load only the first prefix has changed before filtering
class CitySession {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!,
                                category: String(describing: CitySession.self))
    
    /// The prefix of current `letterSortedCity`
    private var letter: Character? = nil
    
    /// The all alphabetical ordered cities that has the prefix `letter`
    private var letterSortedCity: [City] = []
    
    /// Search all cities that start with specifix text
    ///
    /// Time complexity: O(logn)
    func search(with text: String) -> [City]? {
        guard !text.isEmpty else {
            releaseCities()
            logger.log("call \(#function) with empty string")
            return nil
        }
        guard let firstLetter = text.first?.lowercased() else {
            logger.log("\(#function) can't get firstLetter for open the city's 1-prefix hierarchy")
            return nil
        }
        guard loadCityIfNeeded(from: Character(firstLetter)) else { return nil }
        guard let lowestIndex = bsearchLowestIndex(for: text),
              let largestIndex = bsearchLargestIndex(for: text) else {
            logger.log("\(#function) search not found")
            return []
        }
        return Array(letterSortedCity[lowestIndex...largestIndex])
    }
    
    /// Return the ready status of load the alphabetical ordered city list from file (1-prefix hierarchy) if needed
    private func loadCityIfNeeded(from letter: Character) -> Bool {
        guard self.letter != letter else {
            logger.log("\(#function) skip load \(letter)-CityDictionary")
            return true
        }
        guard let cityURL = Bundle.main.url(forResource: "\(letter)", withExtension: "json") else {
            logger.log("\(#function) can't find the \(letter)")
            return false
        }
        guard let cityData = try? Data(contentsOf: cityURL) else {
            logger.log("\(#function) can't init data from \(cityURL)")
            return false
        }
        guard let citiesStartWithLetter = try? JSONDecoder().decode([City].self, from: cityData) else {
            logger.log("\(#function) can't decode the json to [City]")
            return false
        }
        letterSortedCity = citiesStartWithLetter
        self.letter = letter
        logger.log("load completed, count: \(self.letterSortedCity.count)")
        return true
    }
    
    private func releaseCities() {
        letter = nil
        letterSortedCity = []
    }
    
    /// Search the **lowest** index of citiy that has a specifix prefix
    ///
    /// Time complexity: O(logn)
    private func bsearchLowestIndex(for prefix: String) -> Int? {
        let lowercasedPrefix = prefix.lowercased()
        var candidateSolution: Int? = nil
        var start = 0
        var end = letterSortedCity.count - 1
        let prefixLength = lowercasedPrefix.count
        while start <= end {
            let mid = (start + end) / 2
            let midValue = letterSortedCity[mid]
            let midCityNamePrefix = midValue.name.prefix(prefixLength)
            let result = midCityNamePrefix
                .lowercased()
                .compare(lowercasedPrefix)
                .rawValue
            if result == 0 {
                candidateSolution = mid
                end = mid - 1
            } else if result > 0 {
                end = mid - 1
            } else {
                start = mid + 1
            }
        }
        return candidateSolution
    }
    
    /// Search the **largest** index of citiy that has a specifix prefix
    ///
    /// Time complexity: O(logn)
    private func bsearchLargestIndex(for prefix: String) -> Int? {
        let lowercasedPrefix = prefix.lowercased()
        var candidateSolution: Int? = nil
        var start = 0
        var end = letterSortedCity.count - 1
        let prefixLength = lowercasedPrefix.count
        while start <= end {
            let mid = (start + end) / 2
            let midValue = letterSortedCity[mid]
            let midCityNamePrefix = midValue.name.prefix(prefixLength)
            let result = midCityNamePrefix
                .lowercased()
                .compare(lowercasedPrefix)
                .rawValue
            if result == 0 {
                candidateSolution = mid
                start = mid + 1
            } else if result > 0 {
                end = mid - 1
            } else {
                start = mid + 1
            }
        }
        return candidateSolution
    }
}
