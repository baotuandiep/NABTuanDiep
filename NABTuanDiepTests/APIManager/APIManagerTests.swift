//
//  APIManagerTests.swift
//  NABTuanDiepTests
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import XCTest
@testable import NABTuanDiep

class APIManagerTests: XCTestCase {
    
    var apiManager: APIManager?
    
    override func setUp() {
        super.setUp()
        apiManager = APIManager.shared
    }

    override func tearDown() {
        apiManager = nil
        super.tearDown()
    }
    
    func testFetchDataWithCorrectMethod() {
        let apiManager = self.apiManager!
        
        let expect = XCTestExpectation(description: "callback")
        
        apiManager.loadData(type: ForecastModel.self, path: "/data/2.5/forecast/daily", queryParams: [
            "q": "saigon",
            "cnt": 7,
            "units": TempUnit.metric.rawValue
        ]) {
            expect.fulfill()
            switch $0 {
            case .success:
                XCTAssertTrue(true)
            case .error:
                XCTAssertTrue(false)
            }
        }
        
        wait(for: [expect], timeout: 2)
    }
    
    func testFetchDataWithWrongPath() {
        let apiManager = self.apiManager!
        
        let expect = XCTestExpectation(description: "callback")
        
        apiManager.loadData(type: ForecastModel.self, path: "wrong path", queryParams: [
            "q": "saigon",
            "cnt": 7,
            "units": TempUnit.metric.rawValue
        ]) {
            expect.fulfill()
            switch $0 {
            case .success:
                XCTAssertFalse(true)
            case .error:
                XCTAssertFalse(false)
            }
        }
        
        wait(for: [expect], timeout: 2)
    }
    
    func testFetchDataWithWrongCnt() {
        let apiManager = self.apiManager!
        
        let expect = XCTestExpectation(description: "callback")
        
        apiManager.loadData(type: ForecastModel.self, path: "/data/2.5/forecast/daily", queryParams: [
            "q": "saigon",
            "cnt": 20,
            "units": "wrong unit"
        ]) {
            expect.fulfill()
            switch $0 {
            case .success:
                XCTAssertFalse(true)
            case .error:
                XCTAssertFalse(false)
            }
        }
        
        wait(for: [expect], timeout: 2)
    }
    
    func testFetchDataWithWrongTypeModel() {
        let apiManager = self.apiManager!
        
        let expect = XCTestExpectation(description: "callback")
        
        apiManager.loadData(type: CityModel.self, path: "/data/2.5/forecast/daily", queryParams: [
            "q": "saigon",
            "cnt": 7,
            "units": "wrong unit"
        ]) {
            expect.fulfill()
            switch $0 {
            case .success:
                XCTAssertFalse(true)
            case .error:
                XCTAssertFalse(false)
            }
        }
        
        wait(for: [expect], timeout: 2)
    }
}
