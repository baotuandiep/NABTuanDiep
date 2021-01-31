//
//  MainViewModelTests.swift
//  NABTuanDiepTests
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import XCTest
@testable import NABTuanDiep

class MainViewModelTests: XCTestCase {

    var viewModel: MainViewModel?
    
    override func setUp() {
        super.setUp()
        viewModel = MainViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSetting() {
        var setting = SettingModel.load()
        XCTAssertEqual(setting.cnt, viewModel!.settingModel.cnt)
        XCTAssertEqual(setting.unit, viewModel!.settingModel.unit)
        
        setting.cnt = 2
        setting.save()
        viewModel?.updateSetting()
        
        XCTAssertEqual(setting.cnt, viewModel!.settingModel.cnt)
        XCTAssertEqual(setting.unit, viewModel!.settingModel.unit)
    }
    
    func testFetchDataSuccess() {
        let setting = viewModel?.settingModel ?? SettingModel.load()
        let expect = XCTestExpectation(description: "callback")
        
        viewModel?.model.bind(isNow: false) { data in
            expect.fulfill()
            guard let data = data else {
                return XCTFail("No data")
            }
            XCTAssertEqual(data.list.count, setting.cnt)
        }
        
        viewModel?.loadData(city: "saigon")
        
        wait(for: [expect], timeout: 2)
    }
    
    func testFetchDataFail() {
        let expect = XCTestExpectation(description: "callback")
        
        viewModel?.error.bind {
            expect.fulfill()
            if $0 != nil {
                XCTAssert(true)
            }
        }
        
        viewModel?.loadData(city: "there is no city has this name")
        
        wait(for: [expect], timeout: 2)
    }
    
    func testFetchDataWithCityNameLessThan3Charater() {
        let expect = XCTestExpectation(description: "callback")
        
        var isError = true
        var isHasData = true
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        viewModel?.error.bind {
            isError = $0 != nil
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        viewModel?.model.bind {
            isHasData = $0 != nil
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            expect.fulfill()
            XCTAssertFalse(isError)
            XCTAssertFalse(isHasData)
        }
        
        viewModel?.loadData(city: "th")
        
        wait(for: [expect], timeout: 2)
    }
}
