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
   let sun: Sun?
   let moon: Moon?
   let units: Units?
   let localTime: String?
   let localTimeOffset: Int?
   let hour: [Hour]?

   enum CodingKeys: String, CodingKey {
       case date, name, month
       case symbolValue = "symbol_value"
       case symbolDescription = "symbol_description"
       case symbolValue2 = "symbol_value2"
       case symbolDescription2 = "symbol_description2"
       case tempmin, tempmax, wind, rain, humidity, pressure, snowline
       case uvIndexMax = "uv_index_max"
       case sun, moon, units
       case localTime = "local_time"
       case localTimeOffset = "local_time_offset"
       case hour
   }
}

// MARK: - Hour
struct Hour: Codable {
   let interval, temp, symbolValue, symbolDescription: String
   let symbolValue2, symbolDescription2: String
   let wind: Wind
   let rain, humidity, pressure, clouds: String
   let snowline, windchill, uvIndex: String

   enum CodingKeys: String, CodingKey {
       case interval, temp
       case symbolValue = "symbol_value"
       case symbolDescription = "symbol_description"
       case symbolValue2 = "symbol_value2"
       case symbolDescription2 = "symbol_description2"
       case wind, rain, humidity, pressure, clouds, snowline, windchill
       case uvIndex = "uv_index"
   }
}

// MARK: - Wind
struct Wind: Codable {
   let speed: String
   let dir: String?
   let symbol, symbolB, gusts: String
}

// MARK: - Moon
struct Moon: Codable {
   let moonIn, out, lumi, desc: String
   let symbol: String

   enum CodingKeys: String, CodingKey {
       case moonIn = "in"
       case out, lumi, desc, symbol
   }
}

// MARK: - Sun
struct Sun: Codable {
   let sunIn, mid, out: String

   enum CodingKeys: String, CodingKey {
       case sunIn = "in"
       case mid, out
   }
}

// MARK: - Units
struct Units: Codable {
   let temp, wind, rain, pressure: String
   let snowline: String
}
