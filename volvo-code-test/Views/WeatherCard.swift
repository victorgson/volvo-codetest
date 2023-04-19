//
//  WeatherCard.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import SwiftUI

struct WeatherCard: View {
    
    @ObservedObject var viewModel: WeatherCardViewModel
    
    var body: some View {
        NavigationLink {
            if let weatherDetails = viewModel.weatherData {
                WeatherDetails(weatherData: weatherDetails)
            } else {
                ProgressView()
            }
            
        } label: {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 400).foregroundColor(.blue)
                VStack {
                    if let weather = viewModel.weatherData {
                        Image(systemName: weather.weather.first!.symbolCode.rawValue).resizable().aspectRatio(contentMode: .fit).frame(maxWidth: .infinity, maxHeight: 150).padding()
                        Text(weather.weather[0].cityName)
                        
                        Text("Temperature tomorrow at \(weather.weather[0].time)")
                        Text("\(weather.weather[0].temp) celsius")
                        
                        ForEach(weather.weather, id: \.time) { weather in
                            LazyVGrid(columns: [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]) {
                                Text("\(weather.time) ")
                                Image(systemName: weather.symbolCode.rawValue)
                                Text("\(weather.temp) C")
                            }
                        }
                    }
                    else {
                        ProgressView()
                    }
                    
                }
            }.shadow(radius: 10)
        }.buttonStyle(.plain)
    }
}

//struct WeatherCard_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherCard(viewModel: WeatherCardViewModel())
//    }
//}
