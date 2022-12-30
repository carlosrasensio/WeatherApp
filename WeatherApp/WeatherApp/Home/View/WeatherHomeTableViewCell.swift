//
//  WeatherHomeTableViewCell.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import UIKit

class WeatherHomeTableViewCell: UITableViewCell {
  static let cellId = "weatherHomeTableViewCell"

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}

// MARK: Setup UI

extension WeatherHomeTableViewCell {
  func setupUI() {
    backgroundColor = .white
    textLabel?.textColor = Constants.appColor
    textLabel?.font = UIFont.systemFont(ofSize: 20)
  }
}
