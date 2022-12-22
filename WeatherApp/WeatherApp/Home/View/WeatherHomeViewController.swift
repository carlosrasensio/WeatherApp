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
  private lazy var backgroundButton = UIButton()
  private lazy var cityLabel = UILabel()
  private lazy var countryCodeLabel = UILabel()
  private lazy var weatherImageVIew = UIImageView()
  private lazy var temperatureLabel = UILabel()
  private lazy var tableView = UITableView()
  
  // MARK: Variables
  private let cellId = "cellId"
  private let weatherArray = [("Monday", "19℃"), ("Tuesday", "20℃"), ("Wednesday", "21℃"), ("Thursday", "22℃")]
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupInfo()
  }
}

// MARK: - Private configuration methods

private extension WeatherHomeViewController {
  func setupUI() {
    setupActivityIndicator()
    setupBackgroundButton()
    setupCityLabel()
    setupCountryCodeLabel()
    setupWeatherImageView()
    setupTemperatureLabel()
    setupTableView()
  }
  
  func setupInfo() {
    cityLabel.text = Constants.location.city
    countryCodeLabel.text = Constants.location.countyCode.uppercased()
    weatherImageVIew.image = UIImage(named: "iconEiffelTower")
    temperatureLabel.text = "18℃"
  }
  
  func setupActivityIndicator() {
    view.addSubview(activityIndicator)
    
    activityIndicator.style = .large
    activityIndicator.color = .white
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  func setupBackgroundButton() {
    view.addSubview(backgroundButton)
    
    backgroundButton.setImage(UIImage(named: "imageParisHome"), for: .normal)
    backgroundButton.addTarget(self, action:#selector(didTapBackgroundButton), for: .touchUpInside)
    backgroundButton.translatesAutoresizingMaskIntoConstraints = false
    backgroundButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    backgroundButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    backgroundButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    backgroundButton.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  func setupCityLabel() {
    view.addSubview(cityLabel)
    
    cityLabel.textColor = Constants.appColor
    cityLabel.font = UIFont.boldSystemFont(ofSize: 32)
    cityLabel.translatesAutoresizingMaskIntoConstraints = false
    cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
    cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
  }
  
  func setupCountryCodeLabel() {
    view.addSubview(countryCodeLabel)
    
    countryCodeLabel.textColor = Constants.appColor
    countryCodeLabel.font = UIFont.systemFont(ofSize: 18)
    countryCodeLabel.translatesAutoresizingMaskIntoConstraints = false
    countryCodeLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8).isActive = true
    countryCodeLabel.centerXAnchor.constraint(equalTo: cityLabel.centerXAnchor).isActive = true
  }
  
  func setupWeatherImageView() {
    view.addSubview(weatherImageVIew)
    
    weatherImageVIew.translatesAutoresizingMaskIntoConstraints = false
    weatherImageVIew.topAnchor.constraint(equalTo: countryCodeLabel.bottomAnchor, constant: 18).isActive = true
    weatherImageVIew.centerXAnchor.constraint(equalTo: countryCodeLabel.centerXAnchor).isActive = true
  }
  
  func setupTemperatureLabel() {
    view.addSubview(temperatureLabel)
    
    temperatureLabel.textColor = Constants.appColor
    temperatureLabel.font = UIFont.boldSystemFont(ofSize: 40)
    temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    temperatureLabel.topAnchor.constraint(equalTo: weatherImageVIew.bottomAnchor, constant: 8).isActive = true
    temperatureLabel.centerXAnchor.constraint(equalTo: weatherImageVIew.centerXAnchor).isActive = true
  }
  
  func setupTableView() {
    view.addSubview(tableView)
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: backgroundButton.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  func showLoading(_ value: Bool) {
    activityIndicator.isHidden = !value
    if value {
      activityIndicator.startAnimating()
    } else {
      activityIndicator.stopAnimating()
    }
  }
}

// MARK: - Actions

private extension WeatherHomeViewController {
  @objc func didTapBackgroundButton() {
    // TODO: navigate
  }
}

// MARK: - UITableViewDataSource

extension WeatherHomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    weatherArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .magenta
    let item = weatherArray[indexPath.row]
    cell.textLabel?.text = "\(item.0) - \(item.1)"
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
    
    return cell
  }
  

}

// MARK: - UITableViewDelegate

extension WeatherHomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO: navigate
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      140
  }
}
