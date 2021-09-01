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
    var descriptionCurrent : [String:Day] = [:]
    var temp:Temperatures?

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
            let current = jsonResult.day
            self.temp = jsonResult
            
            self.descriptionCurrent =  current
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
        
        let setKey = resultSearch.keys
        let orderKeys = setKey.sorted(by: <)
      
        
        let currentOrderKey = currentKey.sorted{
            $1 <= $0
        }
//        print(currentOrderKey)
        
        
        
//        let sorted = resultSearch.sorted { $0.key < $1.key }
//        let keysArraySorted = Array(sorted.map({ $0.key }))
//        let valuesArraySorted = Array(sorted.map({ $0.value }))
        
        func sortWithKeys(_ dict: [String: Any]) -> [String: Any] {
            let sorted = dict.sorted(by: { $0.key < $1.key })
            var newDict: [String: Any] = [:]
            for sortedDict in sorted {
                newDict[sortedDict.key] = sortedDict.value
                //print(newDict)
            }
            return newDict
        }
        
//        if currentKey.count > 1 {
//            let setKey = resultSearch.keys
//            let orderKeys = setKey.sorted(by: <)
//            print(orderKeys)
//        }
        
         
        
        
        
//        let setKey = resultSearch.keys
//        let orderKeys = setKey.sorted(by: <)
//        print(orderKeys)
////
//        let setName = currentIndexKey.name.sorted(by: >)
//        print("\(currentIndexKey.name)")
//        let valueName = currentIndexKey.name
//        let orderValue = valueName.sorted{
//            return $0 < $1
//        }
       
        
        cell.weekdayLabel.text = "\(currentIndexKey.name)"
        cell.minimumTemperatureLabel.text = "\(currentIndexKey.tempmin)°"
        cell.maximumTemperatureLabel.text = "\(currentIndexKey.tempmax)°"
        cell.labelDirection.text = "\(currentIndexKey.wind.speed) - \(currentIndexKey.wind.gusts)\n Km/h"
   
        cell.iconWeather.image = UIImage(named: "")
        cell.iconDirection.image = UIImage(named: "")
        
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
            headerView.backgroundColor = .red
            headerView.translatesAutoresizingMaskIntoConstraints = false
            headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200)
            return headerView
        }()
        
        let dayDescriptionLabel: UILabel = {
          let dayDescriptionLabel =  UILabel()
            dayDescriptionLabel.textColor = .black
            dayDescriptionLabel.textAlignment = .left
            dayDescriptionLabel.backgroundColor = .link
            dayDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            dayDescriptionLabel.numberOfLines = 0
            
//            let setKey = resultSearch.keys
//            let orderKeys = setKey.sorted(by: <)
//            let firstKey = orderKeys.first
            
//            dayDescriptionLabel.text = "\(firstKey!)"
            //print(orderKeys)
            
        return dayDescriptionLabel
        }()
        
        let iconWeather: UIImageView = {
           let iconWeather = UIImageView()
            iconWeather.contentMode = .scaleAspectFit
            iconWeather.layer.masksToBounds = true
            iconWeather.layer.cornerRadius = 10
            iconWeather.backgroundColor = .green
            iconWeather.translatesAutoresizingMaskIntoConstraints = false
            return iconWeather
        }()
        
        let actualTemperatureLabel: UILabel = {
          let actualTemperatureLabel =  UILabel()
            actualTemperatureLabel.textColor = .black
            actualTemperatureLabel.textAlignment = .center
            actualTemperatureLabel.backgroundColor =  .yellow
            actualTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return actualTemperatureLabel
        }()
        
        let iconDirection:UIImageView = {
            let iconDirection = UIImageView()
            iconDirection.contentMode = .scaleAspectFit
            iconDirection.layer.masksToBounds = true
            iconDirection.layer.cornerRadius = 10
            iconDirection.backgroundColor = .purple
            iconDirection.translatesAutoresizingMaskIntoConstraints = false
            return iconDirection
        }()
        
        let labelDirection:UILabel = {
            let labelDirection = UILabel()
            labelDirection.textColor = .black
            labelDirection.textAlignment = .center
            labelDirection.backgroundColor = .blue
            labelDirection.numberOfLines = 0
            labelDirection.translatesAutoresizingMaskIntoConstraints = false
            labelDirection.font = UIFont.systemFont(ofSize: 15.0)
            
            return labelDirection
        }()
        
        headerView.addSubview(dayDescriptionLabel)
        headerView.addSubview(iconWeather)
        headerView.addSubview(actualTemperatureLabel)
        headerView.addSubview(iconDirection)
        headerView.addSubview(labelDirection)
        
        
        dayDescriptionLabel.frame =  CGRect(x: 20, y: 20, width: view.frame.size.width-195, height: 50)
        iconWeather.frame = CGRect(x: 20, y: 80, width: view.frame.size.width-280, height: 80)
        actualTemperatureLabel.frame = CGRect(x: iconWeather.frame.size.width + 40, y: 80, width: view.frame.size.width-300 , height: 80)
        iconDirection.frame = CGRect(x: 260, y: 20, width: view.frame.size.width-300, height: 80)
        labelDirection.frame = CGRect(x: 260, y: 110, width: view.frame.size.width-300, height: 75)
        return headerView
    }
    
    
}
