//
//  String+Extensions.swift
//  Devskiller
//
//  Created by Muhammad Umair  on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

extension String {
    
    /// Localizes the string using the app's localization files.
    /// - Parameter defaultValue: A fallback value if the localization key is not found.
    /// - Returns: The localized string or the default value if the key is not found.
    func localized(defaultValue: String = "") -> String {
        let localizedString = NSLocalizedString(self, comment: "")
        return localizedString.isEmpty ? defaultValue : localizedString
    }
    
    /// Converts the string to a Date using ISO8601 format.
    /// - Returns: A Date object if conversion is successful, otherwise nil.
    func toDate() -> Date? {
        let dateFormatter = ISO8601DateFormatter() // Use ISO8601DateFormatter for standard date formatting
        return dateFormatter.date(from: self)
    }
    
    /// Formats a date string from ISO8601 format to "yyyy-MM-dd 'at' HH:mm" format.
    /// - Returns: A formatted date and time string, or nil if conversion fails.
    func formattedDateAndTime() -> String? {
        // Create a DateFormatter to parse the input date string
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Set timeZone to GMT to prevent conversion
        
        // Convert the input string to a Date object
        guard let date = inputFormatter.date(from: self) else {
            return nil
        }
        
        // Create another DateFormatter to format the Date object to the desired output format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Set timeZone to GMT to ensure the same display
        
        // Format the Date object to a string
        return outputFormatter.string(from: date)
    }
    
    /// Calculates the number of days between two date strings.
    /// - Parameter toDate: The end date as a string.
    /// - Returns: The number of days between the two dates, or nil if conversion fails.
    func daysBetween(to toDate: String) -> Int? {
        // Define the date formats that might be used
        let dateFormats = [
            "yyyy-MM-dd HH:mm:ss Z",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        ]
        
        // Create a date formatter
        let dateFormatter = DateFormatter()
        
        // Try to convert the start date string to a Date object
        var startDate: Date? = nil
        for format in dateFormats {
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: self) {
                startDate = date
                break
            }
        }
        
        // Try to convert the end date string to a Date object
        var endDate: Date? = nil
        for format in dateFormats {
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: toDate) {
                endDate = date
                break
            }
        }
        
        // Ensure both dates were successfully parsed
        guard let start = startDate, let end = endDate else {
            return nil
        }
        
        // Calculate the number of days between the two dates
        let calendar = Calendar.current
        let startOfDayStart = calendar.startOfDay(for: start)
        let startOfDayEnd = calendar.startOfDay(for: end)
        let components = calendar.dateComponents([.day], from: startOfDayStart, to: startOfDayEnd)
        return components.day
    }
    
    /// Converts the string to a URL object.
    /// - Returns: A URL object if the string is a valid URL, otherwise nil.
    func toURL() -> URL? {
        return URL(string: self)
    }
    
    /// Converts the string to a YouTube URL using the base URL.
    /// - Returns: A URL object if the conversion is successful, otherwise nil.
    func toYouTubeURL() -> URL? {
        let youtubeBaseURL = "https://www.youtube.com/watch?v="
        return URL(string: youtubeBaseURL + self)
    }
}
