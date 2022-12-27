//
//  WeatherDetailCollectionViewCell.swift
//  WeatherApp
//
//  Created by Carlos Rodriguez Asensio on 26/12/22.
//

import UIKit

class WeatherDetailCollectionViewCell: UICollectionViewCell {
  // MARK: Objects
  private lazy var weatherImageVIew = UIImageView()
  private lazy var hourLabel = UILabel()
  private lazy var temperatureLabel = UILabel()
  private lazy var weatherDescriptionLabel = UILabel()
  
  // MARK: Variables
  static let cardId = "cardId"
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setup
  override func layoutSubviews() {
    super.layoutSubviews()
    
    weatherImageVIew.frame = CGRect(
      x: 5,
      y: 0,
      width: contentView.frame.size.width-10,
      height: contentView.frame.size.height-50)
    
    hourLabel.frame = CGRect(
      x: 5,
      y: contentView.frame.size.height-90,
      width: contentView.frame.size.width-50,
      height: 50)
    
    temperatureLabel.frame = CGRect(
      x: 5,
      y: contentView.frame.size.height-70,
      width: contentView.frame.size.width-50,
      height: 50)
    
    weatherDescriptionLabel.frame = CGRect(
      x: 5,
      y: contentView.frame.size.height-50,
      width: contentView.frame.size.width-50,
      height: 50)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    weatherImageVIew.image = nil
    hourLabel.text = nil
    temperatureLabel.text = nil
    weatherDescriptionLabel.text = nil
  }
  
  public func setupInfo(imageUrl: String?, hour: Date?, temperature: Double, weatherDescription: String) {
    weatherImageVIew.getImageFromURL(urlString: imageUrl ?? "icnOpenWeather")
    hourLabel.text = hour?.dateToHourString()
    temperatureLabel.text = "\(temperature)℃"
    weatherDescriptionLabel.text = weatherDescription
  }
}

// MARK: - Private UI methods

extension WeatherDetailCollectionViewCell {
  func setupUI() {
    contentView.backgroundColor = .white
    contentView.clipsToBounds = true
    setupCell()
    setupWeatherImageView()
    setupHourLabel()
    setupTemperatureLabel()
    setupWeatherDescriptionLabel()
  }
  
  func setupCell() {
    contentView.layer.cornerRadius = 6.0
    contentView.layer.borderWidth = 1.0
    contentView.layer.borderColor = UIColor.clear.cgColor
    contentView.layer.masksToBounds = true

    layer.shadowColor = Constants.appColor.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2.0)
    layer.shadowRadius = 6.0
    layer.shadowOpacity = 1.0
    layer.masksToBounds = false
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    layer.backgroundColor = UIColor.clear.cgColor
  }
  
  func setupWeatherImageView() {
    contentView.addSubview(weatherImageVIew)
    
    weatherImageVIew.clipsToBounds = true
    weatherImageVIew.backgroundColor = .clear
  }
  
  func setupHourLabel() {
    contentView.addSubview(hourLabel)

    hourLabel.textColor = Constants.appColor
    hourLabel.font = UIFont.boldSystemFont(ofSize: 14)
    hourLabel.textAlignment = .center
  }
  
  func setupTemperatureLabel() {
    contentView.addSubview(temperatureLabel)

    temperatureLabel.textColor = Constants.appColor
    temperatureLabel.font = UIFont.boldSystemFont(ofSize: 14)
    temperatureLabel.textAlignment = .center
  }
  
  func setupWeatherDescriptionLabel() {
    contentView.addSubview(weatherDescriptionLabel)

    weatherDescriptionLabel.textColor = Constants.appColor
    weatherDescriptionLabel.textAlignment = .center
    weatherDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
    weatherDescriptionLabel.numberOfLines = 0
    temperatureLabel.textAlignment = .center
  }
}
