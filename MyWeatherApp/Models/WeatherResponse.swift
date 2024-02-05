//
//  WeatherResponse.swift
//  MyWeatherApp
//
//  Created by Vineet Gandham on 1/31/24.
//

// WeatherResponse.swift
import Foundation


// Codable is a protocol in Swift that combines the Encodable and Decodable protocols.
// Conforming to Codable enables types to be encoded to and decoded from external representations like JSON.
// Codable simplifies the process of serializing and deserializing data, making it easy to work with external representations.
struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let main: String
}


