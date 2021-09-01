//
//  ViewController.swift
//  WeatherApp
//
//  Created by Felipe Ignacio Zapata Riffo on 24-08-21.



import UIKit
import Foundation

class WeatherViewController: UIViewController {
    
    //MARK: - Variables
    var resultSearch: [String:Day] = [:]
    var arrayDay = [Day]()
    var descriptionDay = [Day]()
    var localy : String?
    let urlString = "http://api.meteored.cl/index.php?api_lang=cl&localidad=18578&affiliate_id=bo5dpxv31l1r&v=3.0"

    //MARK: - tableView
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identefier)
        return tableView
    }()
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherApi()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
    }
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame =  CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    //MARK: - fetchAPI
    func fetchWeatherApi (){
       let urlString = "http://api.meteored.cl/index.php?api_lang=cl&localidad=18578&affiliate_id=bo5dpxv31l1r&v=3.0"
       
       guard let url = URL(string: urlString) else {
           return
       }
       let task = URLSession.shared.dataTask(with: url) { data, _, error in
           guard let data = data, error == nil else {
               return
           }
          do{
              let jsonResult = try JSONDecoder().decode(Temperatures.self, from: data)
            self.arrayDay.append(jsonResult.day["1"]!)
            self.arrayDay.append(jsonResult.day["2"]!)
            self.arrayDay.append(jsonResult.day["3"]!)
            self.arrayDay.append(jsonResult.day["4"]!)
            self.arrayDay.append(jsonResult.day["5"]!)
            self.descriptionDay.append(jsonResult.day["1"]!)
            self.localy = jsonResult.location
              DispatchQueue.main.async {
                self.resultSearch = jsonResult.day
                self.tableView.tableHeaderView = self.createTableHeader()
                self.tableView.reloadData()
              }
          }
          catch {
              print(error)
          }
      }
      task.resume()
    }
    
}
 
//MARK: - tableView functions
extension WeatherViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identefier, for: indexPath) as! WeatherTableViewCell
       
        let keysArray = Array(resultSearch.keys)
        let currentKey = keysArray[indexPath.row]
        let currentIndexKey:Day = resultSearch[currentKey]!
        
        let nameDay = arrayDay[indexPath.row].name
        cell.weekdayLabel.text = "\(nameDay)"
        cell.minimumTemperatureLabel.text = "\(currentIndexKey.tempmin)°"
        cell.maximumTemperatureLabel.text = "\(currentIndexKey.tempmax)°"
        cell.labelDirection.text = "\(currentIndexKey.wind.speed) - \(currentIndexKey.wind.gusts)\n Km/h"
        
        let iconImage = arrayDay[indexPath.row].symbolValue2
        cell.iconWeather.image = UIImage(named: iconImage)
        cell.iconDirection.image = UIImage(named: "wind")
   
        return cell
    }
    
    //MARK: - didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - createTableHeader
    func createTableHeader () -> UIView{
        
        
        let headerView : UIView = {
            let headerView = UIView()
            headerView.backgroundColor = UIColor(red: 51/255.0, green: 138/255.0, blue: 255/255.0, alpha: 1.0)
            headerView.translatesAutoresizingMaskIntoConstraints = false
            headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200)
            return headerView
        }()
        
        let dayDescriptionLabel: UILabel = {
          let dayDescriptionLabel =  UILabel()
            dayDescriptionLabel.textColor = .white
            dayDescriptionLabel.textAlignment = .left
            dayDescriptionLabel.backgroundColor = .clear
            dayDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            dayDescriptionLabel.numberOfLines = 0
            dayDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 25) 
            dayDescriptionLabel.text = "\(descriptionDay[0].symbolDescription)"
            return dayDescriptionLabel
        }()
        
        let iconWeather: UIImageView = {
           let iconWeather = UIImageView()
            iconWeather.contentMode = .scaleAspectFit
            iconWeather.layer.masksToBounds = true
            iconWeather.layer.cornerRadius = 10
            iconWeather.backgroundColor = .clear
            iconWeather.translatesAutoresizingMaskIntoConstraints = false
            iconWeather.image = UIImage(named: "\(descriptionDay[0].symbolValue2)")
            return iconWeather
        }()
        
        let minTemperatureLabel: UILabel = {
          let minTemperatureLabel =  UILabel()
            minTemperatureLabel.textColor = .white
            minTemperatureLabel.textAlignment = .center
            minTemperatureLabel.backgroundColor = .clear
            minTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 20)
            minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
            minTemperatureLabel.text = "\(descriptionDay[0].tempmin)°"
        return minTemperatureLabel
        }()
        
        let iconDirection:UIImageView = {
            let iconDirection = UIImageView()
            iconDirection.contentMode = .scaleAspectFit
            iconDirection.layer.masksToBounds = true
            iconDirection.layer.cornerRadius = 10
            iconDirection.translatesAutoresizingMaskIntoConstraints = false
            iconDirection.image = UIImage(named: "wind")
            return iconDirection
        }()
        
        let labelDirection:UILabel = {
            let labelDirection = UILabel()
            labelDirection.textColor = .white
            labelDirection.textAlignment = .center
            labelDirection.backgroundColor = .clear
            labelDirection.numberOfLines = 0
            labelDirection.translatesAutoresizingMaskIntoConstraints = false
            labelDirection.font = UIFont.boldSystemFont(ofSize: 18)
            labelDirection.text = "\(descriptionDay[0].wind.speed) - \(descriptionDay[0].wind.gusts) Km/h"
            
            return labelDirection
        }()
        
        let tempDescription: UILabel = {
            let tempDescription = UILabel()
            tempDescription.textColor = .white
            tempDescription.textAlignment = .center
            tempDescription.backgroundColor = .clear
            tempDescription.numberOfLines = 0
            tempDescription.font = UIFont.boldSystemFont(ofSize: 15)
            tempDescription.translatesAutoresizingMaskIntoConstraints = false
            tempDescription.text = "Sensación de \(descriptionDay[0].tempmax)° en \(localy!)"
            return tempDescription
        }()
        
        headerView.addSubview(dayDescriptionLabel)
        headerView.addSubview(iconWeather)
        headerView.addSubview(minTemperatureLabel)
        headerView.addSubview(iconDirection)
        headerView.addSubview(labelDirection)
        headerView.addSubview(tempDescription)
        
        
        dayDescriptionLabel.frame =  CGRect(x: 20, y: 10, width: view.frame.size.width-195, height: 50)
        iconWeather.frame = CGRect(x: 50, y: 60, width: view.frame.size.width-280, height: 100)
        minTemperatureLabel.frame = CGRect(x: iconWeather.frame.size.width + 70, y: 80, width: view.frame.size.width-300 , height: 50)
        iconDirection.frame = CGRect(x: 260, y: 20, width: view.frame.size.width-300, height: 80)
        labelDirection.frame = CGRect(x: 260, y: 110, width: view.frame.size.width-300, height: 75)
        tempDescription.frame = CGRect(x: 20, y: 165, width: 330, height:30)
        return headerView
    }
    
    
}
