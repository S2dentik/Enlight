//
//  EnlightTests.swift
//  EnlightTests
//
//  Created by Alexandru Culeva on 12/13/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import XCTest
@testable import EnlightFramework

let currentBundle = Bundle(for: EnlightTests.self)

class EnlightTests: XCTestCase {
    
    var testFile = TestFile.simpleStructWithNoCustomInit
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWhenGivenFileWithAStructWithNoInitWorksFine() {
        XCTAssertEqual(Parser(path: testFile.path)!.string, testFile.output)
    }
}
