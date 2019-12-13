//
//  String+Extensions.swift
//  LabQuestions
//
//  Created by Alex Paul on 12/11/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

extension String {
    
    // creates a timestamp - the created date and time of the object
    // returns a ISO6801DateFormatter
  static func getISOFormatter() -> ISO8601DateFormatter {
    let isoDateFormatter = ISO8601DateFormatter()
      isoDateFormatter.timeZone = .current // the current timezone we are in
      isoDateFormatter.formatOptions = [
        .withInternetDateTime,
        .withFullDate,
        .withFullTime,
        .withFractionalSeconds, // must have this option
        .withColonSeparatorInTimeZone
      ]
    return isoDateFormatter
  }
  
    //  creates a timestamp - gets converted to a string
    // String.getISOTimestamp
  static func getISOTimestamp() -> String {   //Date()
    let isoDateFormatter = getISOFormatter()
    let timestamp = isoDateFormatter.string(from: Date()) // current date and time
    return timestamp
  }
    
  func convertISODate() -> String {
    let isoDateFormatter = String.getISOFormatter()
    guard let date = isoDateFormatter.date(from: self) else {
      return self
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d yyyy, h:mm a"
    
    let dateString = dateFormatter.string(from: date)
    
    return dateString
  }
  
  func isoStringToDate() -> Date {
    let isoDateFormatter = String.getISOFormatter()
    guard let date = isoDateFormatter.date(from: self) else {
      return Date()
    }
    return date
  }
}
