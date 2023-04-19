//
//  ContentView.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import SwiftUI

struct ContentView: View {
    
    let cities: [City] = [City.gothenburg, City.mountainView, City.london, City.newYork, City.berlin]
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false ,content: {
                LazyHGrid(rows: [GridItem(.fixed(50))], content: {
                    ForEach(cities, id: \.self) { city in
                            WeatherCard(viewModel: WeatherCardViewModel(city: city))
                    }
                })
            }).background(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
