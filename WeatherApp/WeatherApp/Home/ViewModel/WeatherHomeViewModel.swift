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
  private var networkManager: NetworkManager
  
  // MARK: Initializer
  init(view: WeatherHomeViewController, networkManager: NetworkManager) {
    self.view = view
    self.networkManager = networkManager
  }
  
  // MARK: Network data
  func getLocationWeatherAsync() async throws -> Forecast {
    do {
      let result = try await networkManager.getLocationWeather()
      print("👀", result)
      return result
    } catch {
      print("❌ [VM] Request failed with error: \(error)")
      throw error
    }
  }
}
