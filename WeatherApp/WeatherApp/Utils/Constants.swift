//
//  Constants.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import Foundation
import UIKit

struct Constants {
  static let appName = "Weather App"
  static let location = (city: "Paris", countyCode: "fr")
  static let appColor = UIColor(red: 1, green: 51/255, blue: 153/255, alpha: 1)

  struct NetworkManager {
    static let version = 2.5
    static let forecast = "/forecast"
    static let weather = "/weather"
    static let units = "metric"
    static let cnt = "cnt"
    static let numberOfTimestamps = 5
    static let apiKey = "c2ac245c2415ab142efeba483dacb09d"
    
    struct URLs {
      static let base = "https://api.openweathermap.org/data/\(NetworkManager.version)"
      static let icon = "https://openweathermap.org/img/w/"

    }
    
    struct Optionals {
      static let units = "&units=\(NetworkManager.units)"
      static let numberOfTimestamps = "&cnt=\(NetworkManager.numberOfTimestamps)"
    }
    
    struct Endpoints {
      static let apiKey = "&appid=\(Constants.NetworkManager.apiKey)"
    }
  }
}
