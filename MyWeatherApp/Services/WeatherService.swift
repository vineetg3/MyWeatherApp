//
//  WeatherService.swift
//  MyWeatherApp
//
//  Created by Vineet Gandham on 1/31/24.
//

// WeatherService.swift
import Foundation

class WeatherService {
    // Define a method named fetchWeather that takes a city name and a completion handler as parameters.
    func fetchWeather(city: String, completion: @escaping (WeatherResponse?) -> Void) {
        let apiKey = "545d5f6a016df696207421881086a203"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        
        // Convert the URL string into a URL object.
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        // Initiate a data task to fetch data from the provided URL.
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Check if there's any error or if data is nil.
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            // Attempt to decode the received JSON data into a WeatherResponse object.
            do {
                // Invoke the completion handler with the decoded WeatherResponse object.
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(weatherResponse)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

