//
//  Api.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import Foundation
import Combine

protocol ApiProtocol {
    func fetchWeather(in city: City) -> AnyPublisher<WeatherResponse, Error>
}

class Api: ApiProtocol {
    private var cancellables = Set<AnyCancellable>()

    private let session = URLSession.shared

    func fetchWeather(in city: City) -> AnyPublisher<WeatherResponse, Error> {
        let baseUrl = URL(string: "https://api.met.no/weatherapi/locationforecast/2.0/complete?lat=\(city.latlon.lat)&lon=\(city.latlon.lon)")!
        
        return Deferred { [self] in
            session.dataTaskPublisher(for: baseUrl)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    
                    return element.data
                }
                .decode(type: WeatherResponse.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
