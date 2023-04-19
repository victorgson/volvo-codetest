//
//  WeatherDetails.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-19.
//

import SwiftUI

struct WeatherDetails: View {
    var weatherData: WeatherDataForView
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10).frame(maxWidth: .infinity, maxHeight: 200).foregroundColor(.green).padding()
            VStack {
                Text("Air pressure: \(weatherData.weather[0].details.airPressure)")
                Text("Air temperature: \(weatherData.weather[0].details.airTemperature)")
                Text("Wind speed: \(weatherData.weather[0].details.windSpeed)")
            }
        }

        
    }
}
