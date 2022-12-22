//
//  UIImageView+URLSession.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 22/12/22.
//

import UIKit

extension UIImageView {
  func getImageFromURL(urlString: String) {
    if self.image == nil {
      self.image = UIImage(named: "icnOpenWeather")
    }
    URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
      guard error == nil else { return }
      DispatchQueue.main.async {
        guard let data = data else { return }
        let image = UIImage(data: data )
        self.image = image
      }
    }.resume()
  }
}
