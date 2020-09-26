//
//  PDFCompressorTests.swift
//  PDFCompressorTests
//
//  Created by Maxim Puchkov on 2020-09-25.
//  Copyright © 2020 com.maximpuchkov. All rights reserved.
//

import XCTest
@testable import PDFCompressor

class PDFCompressorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    /// Test initialization without parameters
    func testInitDefault() throws {
        let compressor = PDFCompressor()
        XCTAssert(compressor.filter == PDFCompressor.kDefaultFilter)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
