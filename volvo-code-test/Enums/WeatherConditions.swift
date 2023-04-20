//
//  WeatherConditions.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-19.
//

import Foundation
import SwiftUI

enum WeatherCondition: String, Decodable {
     case clear = "sun.max.fill"
     case rain = "cloud.rain.fill"
     case cloud = "cloud.fill"
     case snow = "cloud.drizzle.fill"
     case unknown = "questionmark"
    
    var foregroundColor: Color {
        switch self {
        case .clear: return Color(.systemYellow)
        case .rain, .cloud: return Color(.systemGray)
        case .snow: return Color(.systemMint)
        case .unknown: return Color(.black)
        }
    }
}
