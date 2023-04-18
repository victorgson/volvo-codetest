//
//  Api.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import Foundation
import Combine

protocol ApiProtocol {
    //func weather(in cityCoordinates: [Double]) -> AnyPublisher<Void
}

class Api: ApiProtocol {
    private var cancellables = Set<AnyCancellable>()
    private let baseUrl = URL(string: "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=51.5&lon=0")!
    
    private let session = URLSession.shared
    
    
    init() {
        fetchWeather().sink { completion in
            switch completion {
            case .failure(let err):
                print(err)
            case .finished:
                print("finito")
            }
        } receiveValue: { weather in
            print(weather)
            print(weather.properties.timeseries[0].data)
        }.store(in: &cancellables)

    }
    

    func fetchWeather() -> AnyPublisher<WeatherResponse, Error> {
        
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
