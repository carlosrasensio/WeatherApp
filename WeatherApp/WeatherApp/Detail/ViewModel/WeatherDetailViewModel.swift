//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 30/12/22.
//

import Foundation

final class WeatherDetailViewModel {
  // MARK: Variables
  private weak var view: WeatherDetailViewController?
  var listItem: ListItem?
  
  var day: String {
    guard let listItem else { return "Unknown day" }
    
    return listItem.dateString.stringtoDate()?.dateToHourString() ?? listItem.dateString
  }
  
  var imageURL: String? {
    guard let listItem else { return "Unknown day" }
    
    return Constants.NetworkManager.URLs.icon + listItem.weather[0].icon + ".png"
  }
  
  var temperature: String {
    guard let listItem else { return "Unknown temperature" }
    
    return "\(listItem.main.temp)℃"
  }
  
  var weatherDescription: String {
    guard let listItem else { return "Unknown weather description" }
    
    return listItem.weather[0].weatherDescription
  }
  
  // MARK: Initializer
  init(view: WeatherDetailViewController) {
    self.view = view
  }
}
