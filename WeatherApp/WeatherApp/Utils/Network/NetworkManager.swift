//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import Foundation

protocol NetworkManagerProtocol {
  var requestHandler: RequestHandler { get }
  func getLocationWeather(completion: @escaping (Result<LocationWeather, NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
  let requestHandler = RequestHandler()
  
  func getLocationWeather(completion: @escaping (Result<LocationWeather, NetworkError>) -> Void) {
    var request = self.requestHandler.getRequest()
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-type")
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if let error {
        print("\n❌ Transport Error: \(error.localizedDescription)")
        completion(.failure(.transportError(error)))
        return
      }
      
      if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
        print("\n❌ Server Error: response status code \(response.statusCode)")
        completion(.failure(.serverError(statusCode: response.statusCode)))
        return
      }
      
      guard let data else {
        print("\n❌ Error: no data")
        completion(.failure(.noData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let searchedLocationWeather = try decoder.decode(LocationWeather.self, from: data)
        completion(.success(searchedLocationWeather))
      } catch let error {
        print("\n❌ Decoding Error: \(error.localizedDescription)")
        completion(.failure(.decodingError(error)))
      }
    }
    task.resume()
  }
}
