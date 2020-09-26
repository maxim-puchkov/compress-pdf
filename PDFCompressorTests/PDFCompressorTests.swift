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
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    //MARK: - Tests
    /// Test initialization without parameters
    func testInit() throws {
        guard let compressor = try PDFCompressor() else {
            XCTFail()
            return
        }
        XCTAssertEqual(compressor.filter, PDFCompressor.kDefaultFilterName)
    }
    
    /// Test initialization with one parameter specifying a valid filter name
    func testInitDefault() throws {
        guard let compressor = try PDFCompressor(filter: PDFCompressor.kDefaultFilterName) else {
            XCTFail()
            return
        }
        XCTAssertEqual(compressor.filter, PDFCompressor.kDefaultFilterName)
    }
    
    /// Test initialization with one parameter specifying an invalid filter name
    func testInitInvalid() throws {
        let invalidName = "not-a-valid-filter-name"
        do {
            let _ = try PDFCompressor(filter: invalidName)
        } catch PDFCompressionError.NoSuchQuartzFilter(let filterName) {
            XCTAssertEqual(filterName, invalidName)
            return
        }
        XCTFail()
    }
    
    
    

}
