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
  private lazy var backgroundImageView = UIImageView()
  private lazy var cityLabel = UILabel()
  private lazy var countryCodeLabel = UILabel()
  private lazy var tableView = UITableView()
  
  // MARK: Variables
  private var viewModel: WeatherHomeViewModel?
  private var networkManager: NetworkManager
  private let cellId = "cellId"
  private var forecast: Forecast?
  private var weatherList = [List]() {
    didSet {
      reloadTableView()
    }
  }
  
  // MARK: Bind ViewModel
  func bind() {
    viewModel = WeatherHomeViewModel(view: self, networkManager: networkManager)
  }
  
  // MARK: - Initializer
  init(networkManager: NetworkManager) {
    self.networkManager = networkManager
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    setupUI()
    getLocationWeather()
  }
  
  // MARK: Network data
  func getLocationWeather() {
    Task {
      do {
        let result = try await viewModel?.getLocationWeatherAsync()
        forecast = result
        guard let forecast else { throw NetworkError.noData }
        weatherList = forecast.list
        setupInfo()
      } catch {
        print("❌ [V] Request failed with error: \(error)")
        showAlert(title: "ERROR", message: error.localizedDescription)
      }
    }
  }
}

// MARK: - Private UI methods

private extension WeatherHomeViewController {
  func setupUI() {
    DispatchQueue.main.async {
      self.setupActivityIndicator()
      self.setupBackgroundImageView()
      self.setupCityLabel()
      self.setupCountryCodeLabel()
      self.setupTableView()
    }
  }
  
  func setupInfo() {
    guard let forecast else {
      showAlert(title: "ERROR", message: "We have experienced problems retrieving data. Try again later.")
      return
    }
    
    cityLabel.text = forecast.city.name
    countryCodeLabel.text = forecast.city.country
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
    view.addSubview(backgroundImageView)
    
    backgroundImageView.image = UIImage(named: "imageParisHome")
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    backgroundImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  func setupCityLabel() {
    view.addSubview(cityLabel)
    
    cityLabel.textColor = Constants.appColor
    cityLabel.font = UIFont.boldSystemFont(ofSize: 32)
    cityLabel.translatesAutoresizingMaskIntoConstraints = false
    cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
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
  
  func setupTableView() {
    view.addSubview(tableView)
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.backgroundColor = Constants.appColor
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  func reloadTableView() {
    DispatchQueue.main.async {
      self.showLoading(false)
      self.tableView.reloadData()
    }
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
  func navigateToDetailScreen(list: List) {
    let detailScreen = WeatherDetailViewController()
    detailScreen.list = list
    navigationController?.pushViewController(detailScreen, animated: true)
  }
}

// MARK: - UITableViewDataSource

extension WeatherHomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    weatherList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .white
    cell.textLabel?.textColor = Constants.appColor
    cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
    let dateString = weatherList[indexPath.row].dateString
    if let date = dateString.stringtoDate() {
      cell.textLabel?.text = "\(date.dateToString()) - \(weatherList[indexPath.row].main.temp)℃ - \(weatherList[indexPath.row].weather[0].weatherDescription)"
    } else {
      cell.textLabel?.text = "? - \(weatherList[indexPath.row].main.temp) - \(weatherList[indexPath.row].weather[0].weatherDescription)"
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension WeatherHomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigateToDetailScreen(list: weatherList[indexPath.row])
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      100
  }
}
