//
//  WeatherHomeViewController.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 21/12/22.
//

import UIKit

final class WeatherHomeViewController: UIViewController {
  // MARK: Objects
  private lazy var activityIndicator = UIActivityIndicatorView()
  private lazy var cityLabel = UILabel()
  private lazy var todayLabel = UILabel()
  private lazy var imageView = UIImageView()
  private lazy var temperatureLabel = UILabel()
  private lazy var weatherDescriptionLabel = UILabel()
  private lazy var tableView = UITableView()
  
  // MARK: Variables
  private let numberOfRows = Constants.NetworkManager.numberOfDays
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
    setInfo()
  }
}

// MARK: - Private configuration methods

private extension WeatherHomeViewController {
  func setUI() {
    
  }
  
  func setInfo() {
    
  }
  
  func hideActivityIndicator(_ value: Bool = true) {
    if value {
      activityIndicator.stopAnimating()
      activityIndicator.isHidden = value
    } else {
      activityIndicator.isHidden = !value
      activityIndicator.startAnimating()
    }
  }
}

// MARK: - UITableViewDataSource

extension WeatherHomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = WeatherHomeTableViewCell()
    
    return cell
  }
  

}

// MARK: - UITableViewDelegate

extension WeatherHomeViewController: UITableViewDelegate {

}
