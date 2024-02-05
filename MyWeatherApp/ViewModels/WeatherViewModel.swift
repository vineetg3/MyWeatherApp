//
//  WeatherViewModel.swift
//  MyWeatherApp
//
//  Created by Vineet Gandham on 1/31/24.
//

// WeatherViewModel.swift
import SwiftUI

class WeatherViewModel: ObservableObject {
    // This property wrapper indicates that changes to the property's value should trigger updates to any views observing the object containing this property (with help of @ObservedObject wrapper). When the value of a property marked with @Published changes, SwiftUI automatically updates any views that depend on that property.
    @Published var weatherResponse: WeatherResponse?
    private let weatherService = WeatherService()
    
    func fetchWeather(for city: String) {
        weatherService.fetchWeather(city: city) { response in
            DispatchQueue.main.async {
                print("api called")
                self.weatherResponse = response
            }
        }
    }
}
