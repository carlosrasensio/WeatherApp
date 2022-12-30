//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 30/12/22.
//

import Foundation

protocol WeatherDetailViewModelProtocol {
  var view: WeatherDetailViewController? { get }
  var listItem: ListItem? { get set }
  var day: String { get }
  var imageURL: String? { get }
  var temperature: String { get }
  var weatherDescription: String { get }
}

final class WeatherDetailViewModel: WeatherDetailViewModelProtocol {
  // MARK: Variables
  weak var view: WeatherDetailViewController?
  
  var listItem: ListItem?
  
  var day: String {
    guard let listItem else { return "Unknown day" }
    
    return listItem.dateString.stringtoDate()?.dateToHourString() ?? listItem.dateString
  }
  
  var imageURL: String? {
    guard let listItem else { return "Unknown image URL" }
    
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
