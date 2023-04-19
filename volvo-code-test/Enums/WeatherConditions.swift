//
//  WeatherConditions.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-19.
//

import Foundation

enum WeatherCondition: String, Decodable {
     case clear = "sun.max.fill"
     case rain = "cloud.sun.fill"
     case cloud = "cloud.fill"
     case snow = "cloud.drizzle.fill"
     case unknown = "questionmark"
}
