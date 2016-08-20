//
//  JSONTests.swift
//  HackerBooksLite
//
//  Created by Fernando Rodríguez Romero on 8/19/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import XCTest

class JSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParsingCommaSeparatedValues(){
        
        let raw = "Scott Chacon,    Ben Straub, "
        let tokens = parseCommaSeparated(string: raw)
        
        XCTAssertEqual(tokens, ["Scott Chacon", "Ben Straub"])
    }
    
    func testDecoding(){
        XCTFail()
    }
    
    
}
