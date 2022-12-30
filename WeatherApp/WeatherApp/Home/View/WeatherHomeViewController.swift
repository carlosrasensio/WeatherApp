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
  private var viewModel: WeatherHomeViewModelProtocol?
  private var networkManager: WeatherNetworkManager
  private var weatherList = [ListItem]() {
    didSet {
      reloadTableView()
    }
  }
  
  // MARK: Bind ViewModel
  func bind() {
    viewModel = WeatherHomeViewModel(view: self, networkManager: networkManager)
  }
  
  // MARK: - Initializer
  init(networkManager: WeatherNetworkManager) {
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
    setupInfo()
  }
  
  // MARK: Setup info
  func setupInfo() {
    guard let forecast = viewModel?.forecast else {
      showAlert(title: "ERROR", message: "Data not available")
      return
    }
    
    weatherList = forecast.list
    cityLabel.text = viewModel?.city
    countryCodeLabel.text = viewModel?.country
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
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: WeatherHomeTableViewCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.backgroundColor = Constants.appColor
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
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
  
  func reloadTableView() {
    DispatchQueue.main.async {
      self.showLoading(false)
      self.tableView.reloadData()
    }
  }
}

// MARK: - Actions

private extension WeatherHomeViewController {
  func navigateToDetailScreen(listItem: ListItem) {
    let detailScreen = WeatherDetailViewController()
    detailScreen.listItem = listItem
    navigationController?.pushViewController(detailScreen, animated: true)
  }
}

// MARK: - UITableViewDataSource

extension WeatherHomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    weatherList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHomeTableViewCell.cellId, for: indexPath)

    let dateString = weatherList[indexPath.row].dateString
    if let date = dateString.stringtoDate() {
      cell.textLabel?.text = "\(date.dateToHourString())"
    } else {
      cell.textLabel?.text = dateString
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension WeatherHomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigateToDetailScreen(listItem: weatherList[indexPath.row])
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    100
  }
}
