//
//  WeatherDataForView.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-19.
//

import Foundation

struct WeatherDataForView {
    var weather: [Weather]
}
struct Weather {
    var cityName: String
    var temp: String
    var time: String
    var symbolCode: WeatherCondition
    var details: Details
}
