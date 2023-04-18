//
//  WeatherResponse.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import Foundation


struct WeatherResponse: Decodable {
    var properties: Properties
    
    
    struct Properties: Decodable {
        var timeseries: [TimeSeries]
    }
    
    struct TimeSeries: Decodable {
        var time: String
        var data: WeatherData
        struct WeatherData: Decodable{
            var instant: Instant
            struct Instant: Decodable {
                var details: Details
                struct Details: Decodable {
                    var air_pressure_at_sea_level: Double
                    var air_temperature: Double
                    var relative_humidity: Double
                    var wind_from_direction: Double
                    var wind_speed: Double
                }
            }
            
        }
    }
}



