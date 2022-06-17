//
//  CitySessionTests.swift
//  Quick Map Tests
//
//  Created by Chatsopon Deepateep on 17/6/2565 BE.
//

import XCTest
@testable import Quick_Map

class CitySessionTests: XCTestCase {
    var sut: CitySession!

    override func setUpWithError() throws {
        sut = CitySession()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testLoadCitySuccess() throws {
        // Given
        let prefix = "AA"
        // When
        let cities = sut.search(with: prefix)
        // Then
        XCTAssertNotNil(cities)
    }
    
    func testLoadCityEmpty() throws {
        // Given
        let prefix = "AAaaa"
        // When
        let cities = sut.search(with: prefix)
        // Then
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities!.count, 0)
    }
    
    func testLoadCityFail() throws {
        // Given
        /// The prefix that all 1-prefix hierachy files doesn't exists
        let prefix = "สยาม"
        // When
        let cities = sut.search(with: prefix)
        // Then
        XCTAssertNil(cities)
    }
    
    func testLoadCityFailFromEmptyString() throws {
        // Given
        /// The prefix that all 1-prefix hierachy files doesn't exists
        let prefix = ""
        // When
        let cities = sut.search(with: prefix)
        // Then
        XCTAssertNil(cities)
    }

    func testPerformanceExample() throws {
        self.measure {
            _ = sut.search(with: "AA")
        }
    }
}
