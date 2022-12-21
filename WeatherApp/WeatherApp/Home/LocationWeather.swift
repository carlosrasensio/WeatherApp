//
//  LocationWeather.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import Foundation

struct LocationWeather: Codable, Equatable {
  let weather: [Weather]
  let main: Main
  let sys: Sys
  let name: String
  
  static func == (lhs: LocationWeather, rhs: LocationWeather) -> Bool {
    lhs.weather == rhs.weather && lhs.main == rhs.main && lhs.name == rhs.name
  }
}

struct Weather: Codable, Equatable {
  let weatherDescription, icon: String
  
  enum CodingKeys: String, CodingKey {
    case weatherDescription = "description"
    case icon
  }
}

struct Main: Codable, Equatable {
  let temp, tempMin, tempMax: Double
  let humidity: Int
  
  enum CodingKeys: String, CodingKey {
    case temp
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case humidity
  }
}

struct Sys: Codable, Equatable {
  let country: String?
}
