//
//  WeatherCard.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import SwiftUI

struct WeatherCard: View {
    var body: some View {
        ZStack {
    
            RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 400).foregroundColor(.green).padding()
            VStack {
                Image(systemName: "cloud").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: .infinity, maxHeight: 150).padding()
                Text("City name")
                Text("Temperature")
            }
        }.shadow(radius: 10)

    }
}

struct WeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCard()
    }
}
