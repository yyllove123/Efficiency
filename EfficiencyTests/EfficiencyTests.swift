//
//  EfficiencyTests.swift
//  EfficiencyTests
//
//  Created by Yalin on 16/3/29.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import XCTest
@testable import Efficiency

class EfficiencyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_PicModel_scaleHeightToLimitedSize_isSuccess() {
        // origin 100 * 200  to limit 50 * 100
        let outSize = PicModel.scaleHeightToTargetSize(CGSizeMake(100, 200), targetSize: CGSizeMake(50, 100))
        XCTAssert(outSize.width == 50 && outSize.height == 100)
        
        // origin 100 * 200  to limit 100 * 50
        let outSize1 = PicModel.scaleHeightToTargetSize(CGSizeMake(100, 200), targetSize: CGSizeMake(100, 50))
        XCTAssert(outSize1.width == 25 && outSize1.height == 50)
        
        // origin 100 * 200  to limit 200 * 200
        let outSize2 = PicModel.scaleHeightToTargetSize(CGSizeMake(100, 200), targetSize: CGSizeMake(200, 200))
        XCTAssert(outSize2.width == 100 && outSize2.height == 200)
        
        // origin 100 * 200  to limit 200 * 200
//        let outSize3 = PicModel.scaleHeightToTargetSize(CGSizeMake(100, 200), targetSize: CGSizeMake(50, 100))
//        XCTAssert(outSize3.width == 50 && outSize3.height == 100)
    }
}
