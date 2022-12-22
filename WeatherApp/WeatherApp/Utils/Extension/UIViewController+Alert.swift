//
//  UIViewController+Alert.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 22/12/22.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message : String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.view.backgroundColor = Constants.appColor
    alert.view.alpha = 0.5
    alert.view.layer.cornerRadius = 15
    self.present(alert, animated: true)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
      alert.dismiss(animated: true)
    }
  }
}
