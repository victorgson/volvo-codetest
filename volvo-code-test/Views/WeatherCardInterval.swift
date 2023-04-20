//
//  WeatherCardInterval.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-20.
//

import SwiftUI

struct WeatherCardInterval: View {
     
    var weather: Weather
     
    var body: some View {
        Text("\(weather.time) ")
        Image(systemName: weather.symbolCode.rawValue)
        Text("\(weather.temp) C")
    }
}

