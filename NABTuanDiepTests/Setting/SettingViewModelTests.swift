//
//  SettingViewModelTests.swift
//  NABTuanDiepTests
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import XCTest
@testable import NABTuanDiep

class SettingViewModelTests: XCTestCase {

    var viewModel: SettingViewModel?
    
    override func setUp() {
        super.setUp()
        viewModel = SettingViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testData() {
        XCTAssertEqual(viewModel!.cntArray.count, 14)
        XCTAssertEqual(viewModel!.unitArray.count, TempUnit.allCases.count)
    }
}
