//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 22/12/22.
//

import UIKit

final class WeatherDetailViewController: UIViewController {
  // MARK: Objects
  private lazy var activityIndicator = UIActivityIndicatorView()
  private lazy var backgroundImageVIew = UIImageView()
  private lazy var dayLabel = UILabel()
  private lazy var weatherImageVIew = UIImageView()
  private lazy var temperatureLabel = UILabel()
  private lazy var weatherDescriptionLabel = UILabel()
  
  // MARK: Variables
  private var viewModel: WeatherDetailViewModel?
  var listItem: ListItem?
  
  // MARK: Bind ViewModel
  func bind() {
    viewModel = WeatherDetailViewModel(view: self)
    viewModel?.listItem = listItem
  }
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    setupUI()
    setupInfo()
  }
  
  // MARK: Setup info
  func setupInfo() {
    dayLabel.text = viewModel?.day
    weatherImageVIew.getImageFromURL(urlString: viewModel?.imageURL)
    temperatureLabel.text = viewModel?.temperature
    weatherDescriptionLabel.text = viewModel?.weatherDescription
  }
}

// MARK: - Private UI methods

private extension WeatherDetailViewController {
  func setupUI() {
    view.backgroundColor = .white
    setupActivityIndicator()
    setupBackgroundImageView()
    setupDayLabel()
    setupWeatherImageView()
    setupTemperatureLabel()
    setupWeatherDescriptionLabel()
  }
  
  func setupActivityIndicator() {
    view.addSubview(activityIndicator)
    
    activityIndicator.style = .large
    activityIndicator.color = .white
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  func setupBackgroundImageView() {
    view.addSubview(backgroundImageVIew)
    
    backgroundImageVIew.image = UIImage(named: "imageParisDetail")
    backgroundImageVIew.translatesAutoresizingMaskIntoConstraints = false
    backgroundImageVIew.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    backgroundImageVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    backgroundImageVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    backgroundImageVIew.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -120).isActive = true
  }
  
  func setupDayLabel() {
    view.addSubview(dayLabel)
    
    dayLabel.textColor = Constants.appColor
    dayLabel.textAlignment = .center
    dayLabel.font = UIFont.boldSystemFont(ofSize: 30)
    dayLabel.translatesAutoresizingMaskIntoConstraints = false
    dayLabel.topAnchor.constraint(equalTo: backgroundImageVIew.bottomAnchor, constant: 12).isActive = true
    dayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
    dayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true

  }
  
  func setupWeatherImageView() {
    view.addSubview(weatherImageVIew)
    
    weatherImageVIew.translatesAutoresizingMaskIntoConstraints = false
    weatherImageVIew.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 18).isActive = true
    weatherImageVIew.centerXAnchor.constraint(equalTo: dayLabel.centerXAnchor).isActive = true
  }
  
  func setupTemperatureLabel() {
    view.addSubview(temperatureLabel)
    
    temperatureLabel.textColor = Constants.appColor
    temperatureLabel.font = UIFont.boldSystemFont(ofSize: 40)
    temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    temperatureLabel.topAnchor.constraint(equalTo: weatherImageVIew.bottomAnchor, constant: 8).isActive = true
    temperatureLabel.centerXAnchor.constraint(equalTo: weatherImageVIew.centerXAnchor).isActive = true
  }
  
  func setupWeatherDescriptionLabel() {
    view.addSubview(weatherDescriptionLabel)
    
    weatherDescriptionLabel.textColor = Constants.appColor
    weatherDescriptionLabel.textAlignment = .center
    weatherDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
    weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    weatherDescriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8).isActive = true
    weatherDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
    weatherDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
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
