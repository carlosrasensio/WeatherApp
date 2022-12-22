//
//  LocationWeather.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import Foundation

// MARK: - Welcome
struct Forecast: Codable {
  let cod: String
  let message, cnt: Int
  let list: [List]
  let city: City
}

// MARK: - City
struct City: Codable {
  let id: Int
  let name: String
  let country: String
  let population, timezone, sunrise, sunset: Int
}

// MARK: - List
struct List: Codable {
  let date: Int
  let main: MainInfo
  let weather: [Weather]
  let clouds: Clouds
  let wind: Wind
  let visibility: Int
  let pop: Double
  let rain: Rain?
  let dateString: String
  
  enum CodingKeys: String, CodingKey {
    case date = "dt"
    case main, weather, clouds, wind, visibility, pop, rain
    case dateString = "dt_txt"
  }
}

// MARK: - Clouds
struct Clouds: Codable {
  let all: Int
}

// MARK: - MainClass
struct MainInfo: Codable {
  let temp, feelsLike, tempMin, tempMax: Double
  let pressure, seaLevel, grndLevel, humidity: Int
  let tempKf: Double
  
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case seaLevel = "sea_level"
    case grndLevel = "grnd_level"
    case humidity
    case tempKf = "temp_kf"
  }
}

// MARK: - Rain
struct Rain: Codable {
  let the3H: Double
  
  enum CodingKeys: String, CodingKey {
    case the3H = "3h"
  }
}

// MARK: - Weather
struct Weather: Codable {
  let id: Int
  let main: MainInfoEnum
  let weatherDescription, icon: String
  
  enum CodingKeys: String, CodingKey {
    case id, main
    case weatherDescription = "description"
    case icon
  }
}

enum MainInfoEnum: String, Codable {
  case clear = "Clear"
  case clouds = "Clouds"
  case rain = "Rain"
}

// MARK: - Wind
struct Wind: Codable {
  let speed: Double
  let deg: Int
  let gust: Double
}
