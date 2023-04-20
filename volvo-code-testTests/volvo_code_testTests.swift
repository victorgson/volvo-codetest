//
//  volvo_code_testTests.swift
//  volvo-code-testTests
//
//  Created by Victor Gustafsson on 2023-04-18.
//

import XCTest
import Combine
@testable import volvo_code_test


final class volvo_code_testTests: XCTestCase {

    func testSymbols() {
        
        // Given
        let fakeWeatherString = "rainyday"
        let anotherFakeWeatherString = ""
        
        // When
        let result = Summary(symbol_code: fakeWeatherString)
        let result2 = Summary(symbol_code: anotherFakeWeatherString)
        
        // Then
        XCTAssertEqual(result.sfSymbol, WeatherCondition.rain)
        XCTAssertEqual(result2.sfSymbol, .unknown) 
    }
}

