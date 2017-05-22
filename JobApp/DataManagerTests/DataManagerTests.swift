//
//  DataManagerTests.swift
//  DataManagerTests
//
//  Created on 12/12/16.
//  Copyright © 2016 MJD Interactive. All rights reserved.
//

import XCTest
@testable import DataManager

class DataManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    

    func testConnection() {

        APIClient.getCats(){ (cats, error) in

            XCTAssertNil(error, "Error: \(error?.description)")

            guard cats != nil else {
                XCTAssert(false, "🙀 Problem - no cats!")
                return
            }
        }
    }
}
