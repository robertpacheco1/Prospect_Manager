//
//  Date.swift
//  Pac
//
//  Created by Robert Pacheco on 12/26/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import Foundation



//Date helper for audiorecorder
func getCreationDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
        let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}
//Date extension for audioRecorder
extension Date {
        
    static func current(_ calendarComponents: Set<Calendar.Component>) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents(calendarComponents, from: Date())
        return calendar.date(from: components) ?? Date()
    }
    
    /// Current date including year, month, day, hour, and minute.
    static var currentYMDHM: Date {
        current([.year, .month, .day, .hour, .minute])
    }
    
    /// Get the start of today using the current calendar.
    /// - Parameter addingDay: The number of day to add. The default is 0.
    static func startOfToday(addingDay: Int = 0) -> Date? {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return addingDay == 0 ? today : calendar.date(byAdding: .day, value: addingDay, to: today)!
    }
    func dateComponents() -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return components
    }
    
    func dateComponentsToNotify() -> DateComponents {
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: .minute, value: -30, to: self)
        guard let date = newDate else {
            return calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        }
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        return components
    }
    func isEqual(currentDate: Date) -> Bool {
        if self.dateComponents().day == currentDate.dateComponents().day {
            return true
        } else {
            return false
        }
    }
    func isPast(today currentDate: Date) -> Bool {
        if self > currentDate {
            return true
        } else {
            return false
        }
    }
    
    static func from(hour: Int, minutes: Int, year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minutes
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
        
    }
    func toString(dateFormat format : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }
    
    func dateFormatterString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self)
    }
}


extension DateFormatter {
    
    static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        return formatter
    }()
}
