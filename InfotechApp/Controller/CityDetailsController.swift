//
//  CityDetailsController.swift
//  InfotechApp
//
//  Created by Максим Семений on 18.08.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit
import GoogleMaps

class CityDetailsController: UIViewController {
    
    var city: City!
    
    lazy var safeArea = view.layoutMarginsGuide
    
    let weatherInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let mapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: view.frame.size.height / 28, weight: .medium)
        return label
    }()
    
    lazy var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: view.frame.size.height / 40, weight: .regular)
        return label
    }()
    
    let weatherIconImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: view.frame.size.height / 40, weight: .regular)
        return label
    }()
    
    let temperatureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "thermometer")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var minMaxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: view.frame.size.height / 45, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "wind")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: view.frame.size.height / 40, weight: .regular)
        return label
    }()
    
    let humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "humidity")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: view.frame.size.height / 40, weight: .regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        configureWeatherContainer()
        getWeather()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        weatherInfoView.dropShadow()
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        
        let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon), zoom: 6)
        mapView.camera = camera
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: mapView)
        mapView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2).isActive = true
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon)
        marker.title = city.name
        marker.snippet = city.country
        marker.map = mapView
    }
    
    private func configureWeatherContainer() {
        view.addSubview(weatherInfoView)
        
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: weatherInfoView)
        weatherInfoView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 5).isActive = true
        weatherInfoView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10).isActive = true
        
        configureCityNameLabel()
        configureWeatherDescriptionLabelAndIcon()
        configureTempAndIcon()
        configureMinMaxTemp()
        configureWind()
        configureHumidity()
    }
    
    private func configureCityNameLabel() {
        weatherInfoView.addSubview(cityNameLabel)
        
        weatherInfoView.addConstraintsWithFormat(format: "H:|-30-[v0]", views: cityNameLabel)
        weatherInfoView.addConstraintsWithFormat(format: "V:|-20-[v0]", views: cityNameLabel)
    }
    
    private func configureWeatherDescriptionLabelAndIcon() {
        weatherInfoView.addSubview(weatherDescriptionLabel)
        weatherInfoView.addSubview(weatherIconImageView)
        
        weatherInfoView.addConstraintsWithFormat(format: "H:|-20-[v0(50)][v1]", views: weatherIconImageView, weatherDescriptionLabel)
        weatherInfoView.addConstraintsWithFormat(format: "V:[v0]-10-[v1]", views: cityNameLabel, weatherIconImageView)
        weatherDescriptionLabel.centerYAnchor.constraint(equalTo: weatherIconImageView.centerYAnchor).isActive = true
    }
    
    private func configureTempAndIcon() {
        weatherInfoView.addSubview(temperatureLabel)
        weatherInfoView.addSubview(temperatureImageView)
        
        UIHelper.layoutViews(inView: weatherInfoView, nextImageView: temperatureImageView, toInitialImageView: weatherIconImageView, alignNextLabel: temperatureLabel, toInitialLabel: weatherDescriptionLabel, previousLabel: weatherDescriptionLabel)
    }
    
    private func configureMinMaxTemp() {
        weatherInfoView.addSubview(minMaxTemperatureLabel)
        minMaxTemperatureLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 10).isActive = true
        minMaxTemperatureLabel.bottomAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
    }
    
    private func configureWind() {
        weatherInfoView.addSubview(windImageView)
        weatherInfoView.addSubview(windLabel)
        
        UIHelper.layoutViews(inView: weatherInfoView, nextImageView: windImageView, toInitialImageView: weatherIconImageView, alignNextLabel: windLabel, toInitialLabel: weatherDescriptionLabel, previousLabel: temperatureLabel)
    }
    
    private func configureHumidity() {
        weatherInfoView.addSubview(humidityLabel)
        weatherInfoView.addSubview(humidityImageView)
        
        UIHelper.layoutViews(inView: weatherInfoView, nextImageView: humidityImageView, toInitialImageView: weatherIconImageView, alignNextLabel: humidityLabel, toInitialLabel: weatherDescriptionLabel, previousLabel: windLabel)
    }
    
    private func getWeather() {
        WeatherManager.shared.getWeather(cityId: city.id) { [weak self] (weather) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.cityNameLabel.text = self.city.name
                self.weatherDescriptionLabel.text = weather.weather[0].weatherDescription.capitalized
                self.weatherIconImageView.loadImage(from: "http://openweathermap.org/img/w/\(weather.weather[0].icon).png")
                self.temperatureLabel.text = "\(weather.main.temp)°"
                self.minMaxTemperatureLabel.text = "\(weather.main.tempMin)° ~ \(weather.main.tempMax)°"
                self.windLabel.text = "\(weather.wind.speed) km/h"
                self.humidityLabel.text = "\(weather.main.humidity)%"
            }
        }
    }
}
