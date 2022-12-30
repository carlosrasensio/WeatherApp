//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import Foundation

protocol NetworkManagerProtocol {
  func request<T: Codable>(url: URL) async throws -> T
}

class NetworkManager {
  func request<T: Codable>(url: URL) async throws -> T {
    let (data, response) = try await URLSession.shared.data(from: url)

    if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
      print("\n❌ Server Error: response status code \(response.statusCode)")
      throw NetworkError.serverError(statusCode: response.statusCode)
    }
    
    do {
      let result = try JSONDecoder().decode(T.self, from: data)
      return result
    } catch {
      print("\n❌ Decoding Error: \(error.localizedDescription)")
      throw NetworkError.decodingError(error)
    }
  }
}
