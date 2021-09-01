//
//  WeatherEntities.swift
//  WeatherApp
//
//  Created by Felipe Ignacio Zapata Riffo on 25-08-21.
//

import Foundation
// MARK: - Temperatures
struct Temperatures: Codable {
   let status: Int
   let location: String
   let day: [String: Day]
}

// MARK: - Day
struct Day: Codable {
   let date, name, month, symbolValue: String
   let symbolDescription, symbolValue2, symbolDescription2, tempmin: String
   let tempmax: String
   let wind: Wind
   let rain, humidity, pressure, snowline: String?
   let uvIndexMax: String?
   let localTime: String?
   let localTimeOffset: Int?
 

   enum CodingKeys: String, CodingKey {
       case date, name, month
       case symbolValue = "symbol_value"
       case symbolDescription = "symbol_description"
       case symbolValue2 = "symbol_value2"
       case symbolDescription2 = "symbol_description2"
       case tempmin, tempmax, wind, rain, humidity, pressure, snowline
       case uvIndexMax = "uv_index_max"
       case localTime = "local_time"
       case localTimeOffset = "local_time_offset"
 
   }
}
 
// MARK: - Wind
struct Wind: Codable {
   let speed: String
   let dir: String?
   let symbol, symbolB, gusts: String
}
