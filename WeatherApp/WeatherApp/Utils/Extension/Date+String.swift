//
//  Date+String.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 22/12/22.
//

import Foundation

extension Date {
  func dateToString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E, d MMM"
    
    return dateFormatter.string(from: self).uppercased()
  }
  
  func dateToHourString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH"
    
    return dateFormatter.string(from: self) + "h"
  }
}

extension String {
  func stringtoDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-dd-mm HH:mm:ss"
    
    return dateFormatter.date(from: self)
  }
}
