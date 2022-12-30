//
//  WeatherHomeViewModel.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import Foundation

final class WeatherHomeViewModel {
  // MARK: Variables
  private weak var view: WeatherHomeViewController?
  private var networkManager: WeatherNetworkManager
  var forecast: Forecast?
  
  var city: String {
    guard let forecast else { return "Unknown city" }
    
    return forecast.city.name
  }
  
  var country: String {
    guard let forecast else { return "Unknown country" }
    
    return forecast.city.country
  }
  
  // MARK: Initializer
  init(view: WeatherHomeViewController, networkManager: WeatherNetworkManager) {
    self.view = view
    self.networkManager = networkManager
  }
  
  // MARK: Network data
  func getLocationWeatherAsync() async throws -> Forecast {
    do {
      let result = try await networkManager.getLocationWeather()
      forecast = result
      print("👀 Forecast: ", forecast)
      
      return result
    } catch {
      print("❌ [VM] Request failed with error: \(error)")
      throw error
    }
  }
}
