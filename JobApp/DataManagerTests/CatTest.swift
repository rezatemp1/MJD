//
//  CatTest.swift
//  Apply MJD
//
//  Created on 12/12/16.
//  Copyright © 2016 MJD Interactive. All rights reserved.
//

import XCTest
@testable import DataManager

class CatTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSomeData() {
        let data: [String: Any] = [:]
        let cat = Cat(data: data)
        XCTAssertNotNil(cat, "The cat should exist.")
        //etc
    }

}
