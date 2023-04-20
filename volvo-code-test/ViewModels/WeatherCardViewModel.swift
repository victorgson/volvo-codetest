//
//  WeatherCardViewModel.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import Foundation
import Combine
class WeatherCardViewModel: ObservableObject {
    
    internal let api: ApiProtocol
    
    @Published var weatherData: WeatherDataForView?
    private let times: [String] = ["08:00", "12:00", "16:00", "20:00"]
    
    private var subscribers = Set<AnyCancellable>()
    init(city: City, api: ApiProtocol = Api())
    {
        self.api = api
        fetchWeather(for: city)
    }
    
     func fetchWeather(for city : City) {
        api.fetchWeather(in: city).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .failure(let err):
                print(err)
            case .finished:
                print("finished")
                break
            }
        } receiveValue: { [weak self] weather in
            guard let self else { return }
            self.weatherData = fetchWeatherDataForView(times: times, weatherResponse: weather, cityName: city.cityName)
        }.store(in: &subscribers)
    }
        
    private func fetchWeatherDataForView(times: [String], weatherResponse: WeatherResponse, cityName: String) -> WeatherDataForView? {
        var array: [Weather] = []
        for time in times {
            guard let timeInterval = findIntervalTomorrow(at: time, weatherResponse: weatherResponse) else { return nil}
            
            let temp = fetchTemp(at: time, weatherResponse: weatherResponse)
            let symbol = fetchSymbol(weatherResponse: weatherResponse)
            let details = fetchDetails(timeInterval: timeInterval)
            let item = Weather(cityName: cityName, temp: temp, time: time, symbolCode: symbol, details: details)
            array.append(item)
        }
        var data: WeatherDataForView = WeatherDataForView(weather: [])
        
        data.weather = array
        return data
    }
    
    private func fetchDetails(timeInterval: TimeInterval) -> Details {
        return timeInterval.data.instant.details
    }
    
    private func fetchSymbol(weatherResponse: WeatherResponse) -> WeatherCondition {
        guard let startOfDay = findIntervalTomorrow(at: "08:00", weatherResponse: weatherResponse) else { return WeatherCondition.unknown}
        return startOfDay.data.next12Hours?.summary.sfSymbol ?? WeatherCondition.unknown
    }
    
    private func fetchTemp(at time: String, weatherResponse: WeatherResponse) -> String{
        guard let tomorrowAtTime = findIntervalTomorrow(at: time, weatherResponse: weatherResponse) else { return "Error finding tomorrow" }
        let tempAsString = String(tomorrowAtTime.data.instant.details.airTemperature)
        return tempAsString
    }
    private func findIntervalTomorrow(at time: String, weatherResponse: WeatherResponse) -> TimeInterval? {
         let allTomorrow = weatherResponse.properties.timeInterval.filter({$0.isTomorrow})
        guard let timeSerieAtTwelve = allTomorrow.first(where: {$0.hour == String(time)}) else { return nil }
        return timeSerieAtTwelve
    }
}
