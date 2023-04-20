//
//  WeatherResponse.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import Foundation


struct WeatherResponse: Decodable {
    var properties: Properties
}

struct Properties: Decodable {
    var timeInterval: [TimeInterval]
    
    enum CodingKeys: String, CodingKey {
        case timeInterval = "timeseries"
    }
}

struct TimeInterval: Decodable {
    private var time: String
    var data: WeatherData
    
    var date: Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "sv_SV")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter.date(from: time)
    }
    var hour: String? {
        guard let date else { return "No date"}
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: "sv_SV")
        return formatter.string(from: date)
    }
    
    var isTomorrow: Bool {
        if let date = date {
            let calendar = Calendar.current
            return calendar.isDateInTomorrow(date)
        }
        return false
    }
}

struct WeatherData: Decodable {
    let instant: Instant
    let next12Hours: Next12Hours?
    
    enum CodingKeys: String, CodingKey {
        case instant
        case next12Hours = "next_12_hours"
    }
}

struct Instant: Decodable {
    var details: Details
}

struct Next12Hours: Decodable {
    var summary: Summary
}

struct Summary: Decodable {
    var symbol_code: String
    
    var sfSymbol: WeatherCondition {
        switch symbol_code {
        case let str where str.contains("rain"):
            return .rain
        case let str where str.contains("clear") || str.contains("fair"):
            return .clear
        case let str where str.contains("snow"):
            return .snow
        case let str where str.contains("cloud"):
            return .cloud
        default:
            return .unknown
        }
    }
}

struct Details: Decodable {
    var airPressure: Double
    var airTemperature: Double
    var relativeHumidity: Double
    var windFromDirection: Double
    var windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case airPressure = "air_pressure_at_sea_level"
        case airTemperature = "air_temperature"
        case relativeHumidity = "relative_humidity"
        case windFromDirection = "wind_from_direction"
        case windSpeed = "wind_speed"
    }
}
