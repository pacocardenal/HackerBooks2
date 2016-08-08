//
//  MultiDictionaryTests.swift
//  HackerBooksLite
//
//  Created by Fernando Rodríguez Romero on 7/28/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import XCTest

class MultiDictionaryTests: XCTestCase {
    
    let d: MultiDictionary <String, String> = MultiDictionary()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmpty(){
        XCTAssertTrue(d.isEmpty)
    }
    
    
    
//    func testSubscript(){
//        
//    
//        let value = d["Lucas"]
//        
//        // getter
//        XCTAssertNil(value, "Should be empty")
//        
//        
//        // setter
//        d["Lucas"] = "Grijander"
//        XCTAssertFalse(d.isEmpty)
//        
//        let b = d["Lucas"]!.contains("Grijander")
//        XCTAssertTrue(b)
//        
//        
//        
//    }
}
