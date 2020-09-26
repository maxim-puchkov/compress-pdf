//
//  PDFCompressorFilterTests.swift
//  PDFCompressorTests
//
//  Created by Maxim Puchkov on 2020-09-25.
//  Copyright © 2020 com.maximpuchkov. All rights reserved.
//

import XCTest
@testable import PDFCompressor


/// Test creation PDF compressors with different filters.
class PDFCompressorFilterTests: XCTestCase {
  
  /// Test initialization without parameters.
  func testInit() throws {
      guard let compressor = try PDFCompressor() else {
          XCTFail()
          return
      }
      XCTAssertEqual(compressor.filter, PDFCompressor.kDefaultFilterName)
  }
  
  /// Test initialization with one parameter specifying a valid filter name.
  func testInitDefault() throws {
      let defaultName = PDFCompressor.kDefaultFilterName
      guard let compressor = try PDFCompressor(name: defaultName) else {
          XCTFail()
          return
      }
      XCTAssertEqual(compressor.filter, defaultName)
  }
  
  /// Test initialization with one parameter specifying an invalid filter name.
  func testInitInvalid() throws {
      let invalidName = "not-a-valid-filter-name"
      do {
          let _ = try PDFCompressor(name: invalidName)
      } catch PDFCompressionError.NoSuchQuartzFilter(let filterName) {
          XCTAssertEqual(filterName, invalidName)
          return
      }
      XCTFail()
  }
  
}
