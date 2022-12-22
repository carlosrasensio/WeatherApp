//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import Foundation

protocol NetworkManagerProtocol {
  var requestHandler: RequestHandler { get }
  func getLocationWeather() async throws -> Forecast
}

final class NetworkManager: NetworkManagerProtocol {
  let requestHandler = RequestHandler()
  
  func getLocationWeather() async throws -> Forecast {
    let url = requestHandler.getURL()
    let (data, response) = try await URLSession.shared.data(from: url)
    
    if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
      print("\n❌ Server Error: response status code \(response.statusCode)")
      throw NetworkError.serverError(statusCode: response.statusCode)
    }
    
    do {
      let decoder = JSONDecoder()
      let locationWeather = try decoder.decode(Forecast.self, from: data)
      
      return locationWeather
    } catch {
      print("\n❌ Decoding Error: \(error.localizedDescription)")
      throw NetworkError.decodingError(error)
    }
  }
}
