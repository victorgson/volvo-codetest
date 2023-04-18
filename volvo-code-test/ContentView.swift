//
//  ContentView.swift
//  volvo-code-test
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import SwiftUI

struct ContentView: View {
    
    let api = Api()
    var body: some View {
        
        ScrollView(.horizontal ,content: {
            LazyHGrid(rows: [GridItem(.fixed(150), alignment: .center)], content: {
                
                ForEach(Range(1...4)) { i in
                    WeatherCard()
                }
                
            })
        }).background(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
