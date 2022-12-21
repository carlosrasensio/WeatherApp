//
//  RequestHandler.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import Foundation

protocol RequestHandlerProtocol {
  func getURL() -> URL
  func getRequest() -> URLRequest
}

final class RequestHandler: RequestHandlerProtocol {
  func getURL() -> URL {
    let location = "?q=\(Constants.location.city),\(Constants.location.countyCode)"
    let url = URL(string: Constants.NetworkManager.URLs.base +
                  location +
                  Constants.NetworkManager.Optionals.units +
                  Constants.NetworkManager.Optionals.numberOfDays +
                  Constants.NetworkManager.Endpoints.apiKey)!
    
    return url
  }
  
  func getRequest() -> URLRequest {
    let url = getURL()
    var request = URLRequest(url: url)
    
    return request
  }
}