//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Felipe Ignacio Zapata Riffo on 24-08-21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    static let identefier = "WeatherTableViewCell"
    
    public func nib()->UINib{
        return UINib(nibName: "WeatherTableViewCell",
                     bundle: nil)
    }
    let weekdayLabel: UILabel = {
      let weekdayLabel =  UILabel()
        weekdayLabel.textColor = .black
        weekdayLabel.textAlignment = .center
        weekdayLabel.backgroundColor = .clear
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = false
         
    return weekdayLabel
    }()
    
    let minimumTemperatureLabel: UILabel = {
      let minimumTemperatureLabel =  UILabel()
        minimumTemperatureLabel.textColor = .black
        minimumTemperatureLabel.textAlignment = .center
        minimumTemperatureLabel.backgroundColor = .clear
        minimumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    return minimumTemperatureLabel
    }()
    
    let maximumTemperatureLabel: UILabel = {
      let maximumTemperatureLabel =  UILabel()
        maximumTemperatureLabel.textColor = .black
        maximumTemperatureLabel.textAlignment = .center
        maximumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        maximumTemperatureLabel.backgroundColor = .clear
       
    return maximumTemperatureLabel
    }()
    
    let iconWeather: UIImageView = {
       let iconWeather = UIImageView()
        iconWeather.contentMode = .scaleAspectFit
        iconWeather.layer.masksToBounds = true
        iconWeather.layer.cornerRadius = 10
        iconWeather.backgroundColor = .clear
        iconWeather.translatesAutoresizingMaskIntoConstraints = false
        return iconWeather
    }()
    
    let iconDirection:UIImageView = {
        let iconDirection = UIImageView()
        iconDirection.contentMode = .scaleAspectFill
        iconDirection.layer.masksToBounds = true
        iconDirection.layer.cornerRadius = 10
        iconDirection.backgroundColor = .clear
        iconDirection.translatesAutoresizingMaskIntoConstraints = false
        return iconDirection
    }()
    let labelDirection:UILabel = {
        let labelDirection = UILabel()
        labelDirection.textColor = .black
        labelDirection.textAlignment = .center
        labelDirection.backgroundColor = .clear
        labelDirection.numberOfLines = 0
        labelDirection.translatesAutoresizingMaskIntoConstraints = false
        labelDirection.font = UIFont.systemFont(ofSize: 15.0)
        
        return labelDirection
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
        
    }
    
    func setUpView(){
        contentView.addSubview(weekdayLabel)
        contentView.addSubview(iconWeather)
        contentView.addSubview(minimumTemperatureLabel)
        contentView.addSubview(maximumTemperatureLabel)
        contentView.addSubview(iconDirection)
        contentView.addSubview(labelDirection)
        
        
        weekdayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        weekdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        weekdayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        weekdayLabel.widthAnchor.constraint(equalToConstant:80).isActive = true
        
        iconWeather.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        iconWeather.leadingAnchor.constraint(equalTo: weekdayLabel.trailingAnchor, constant: 10).isActive = true
        iconWeather.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        iconWeather.widthAnchor.constraint(equalToConstant: 80).isActive = true
         
        
        minimumTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        minimumTemperatureLabel.leadingAnchor.constraint(equalTo: iconWeather.trailingAnchor, constant: 10).isActive = true
        minimumTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        minimumTemperatureLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true

        maximumTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        maximumTemperatureLabel.leadingAnchor.constraint(equalTo: minimumTemperatureLabel.trailingAnchor, constant: 10).isActive = true
        maximumTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        maximumTemperatureLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        iconDirection.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        iconDirection.leadingAnchor.constraint(equalTo: maximumTemperatureLabel.trailingAnchor, constant: 30).isActive = true
        iconDirection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50).isActive = true
        iconDirection.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelDirection.topAnchor.constraint(equalTo: iconDirection.bottomAnchor,constant: 2).isActive = true
        labelDirection.leadingAnchor.constraint(equalTo: maximumTemperatureLabel.trailingAnchor, constant: 22).isActive = true
        labelDirection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        labelDirection.widthAnchor.constraint(equalToConstant: 50).isActive = true
       
       
        
         
         
    }
     

}

