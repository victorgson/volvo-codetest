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
                RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 400).foregroundColor(.white)
                VStack {
                    if let weather = viewModel.weatherData {
                        let weatherAt12 = weather.weather[1]
                        
                        Image(systemName: weatherAt12.symbolCode.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 150)
                            .padding()
                            .foregroundColor(weatherAt12.symbolCode.foregroundColor)
                        
                        Text(weatherAt12.cityName)
                        Text("Temperature tomorrow at \(weatherAt12.time)")
                        Text("\(weatherAt12.temp) celsius")
                        
                        ForEach(weather.weather, id: \.time) { weather in
                            LazyVGrid(columns: [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]) {
                                WeatherCardInterval(weather: weather)
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
