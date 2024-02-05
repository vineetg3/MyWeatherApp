//
//  ContentView.swift
//  MyWeatherApp
//
//  Created by Vineet Gandham on 1/21/24.
//

// This line imports SwiftUI framework, which provides tools for building user interfaces.
import SwiftUI

struct ContentView: View {
    // State property to keep track of the selected city index in the picker.
    @State private var selectedCityIndex = 0
    // ObservedObject property to observe changes in the WeatherViewModel.
    @ObservedObject private var viewModel = WeatherViewModel()
    
    let cities = ["Dallas", "College Station", "Houston", "Austin", "San Antonio"]
    
    // Function to map weather condition to image asset name
        private func weatherImageName(condition: String) -> String {
            switch condition {
            case "Clear":
                return "sun.max"
            case "Clouds":
                return "cloud"
            case "Rain":
                return "cloud.rain"
            default:
                return "questionmark"
            }
        }
    
    var body: some View {
        VStack {
            Picker(selection: $selectedCityIndex, label: Text("Select a city")) {
                ForEach(0..<cities.count) { index in
                    Text(self.cities[index]).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.top,100)
            .onChange(of: selectedCityIndex,initial:true){
                // Fetch weather data when the selected city changes
                            viewModel.fetchWeather(for: cities[selectedCityIndex])
                        }
            
            //"Whenever the weather response in the view model changes or becomes available, do something with that response."
            // The closure is actually viewModel.weatherResponse { response in ... }
            // we have response object conveniently given to us.
            // Update UI based on the weather response
            if let response = viewModel.weatherResponse {
                Text("Temperature:")
                    .font(.headline)
                    .padding()
                
                Text("\(response.main.temp)°C / \(response.main.temp * 9 / 5 + 32)°F")
                    .font(.title)
                    .padding()
                // Show weather image based on weather condition
                if let weatherCondition = response.weather.first?.main {
                    Image(systemName: weatherImageName(condition: weatherCondition))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.top,10)
                }
                                
                Spacer()
                Spacer()
            } else {
                ProgressView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
