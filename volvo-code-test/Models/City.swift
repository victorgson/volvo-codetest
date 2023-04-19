//
//  LongLat.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import Foundation

struct LatLon {
    var lat: Double
    var lon: Double
}

enum City {
    case gothenburg
    case mountainView
    case london
    case newYork
    case berlin
    
    var latlon: LatLon {
        switch self {
        case .gothenburg:
            return LatLon(lat: 57.708870, lon: 11.974560)
        case .mountainView:
            return LatLon(lat: 38.009838, lon: -122.119232)
        case .london:
            return LatLon(lat: 51.507351, lon: -0.127758)
        case .newYork:
            return LatLon(lat: 40.712776, lon: -74.005974)
        case .berlin:
            return LatLon(lat: 52.520008, lon: 13.404954)
        }
    }
    
    var cityName: String {
        switch self {
        case .gothenburg:
            return "Gothenburg"
        case .mountainView:
            return "Mountain View"
        case .london:
            return "London"
        case .newYork:
            return "New York"
        case .berlin:
            return "Berlin"
        }
    }
}
