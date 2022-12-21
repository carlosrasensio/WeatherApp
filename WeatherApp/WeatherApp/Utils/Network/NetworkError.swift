//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import Foundation

enum NetworkError: Error {
  case transportError(Error)
  case serverError(statusCode: Int)
  case noData
  case decodingError(Error)
  case encodingError(Error)
}
