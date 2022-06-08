//
//  PDFCompressorTests.swift
//  PDFCompressorTests
//
//  Created by Maxim Puchkov on 2020-09-25.
//  Copyright © 2020 com.maximpuchkov. All rights reserved.
//

import XCTest
@testable import PDFCompressor


/// Test compression of PDF documents
class PDFCompressorCompressionTests: XCTestCase {
    
    let compressor: PDFCompressor = PDFCompressor()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    /// Test that a valid input PDF document is compressed
    /// and is written to the `outURL` location.
    func testPDFCompression() throws {
        // Find Test resource by name
        let resource = "01-document"
        guard let inURL = Bundle.module.url(forResource: resource,
                                          withExtension: "pdf") else {
            XCTFail("Test resource not found: \(resource).")
            return
        }
        
        // Output location is in the same directory as input
        let outURL = inURL.deletingLastPathComponent().appendingPathComponent("01-compressed.pdf")
        
        // Copy and compress the input file
        do {
            let outPDF: CFURL = try compressor.compress(inURL, out: outURL)
            XCTAssertEqual(outPDF, outURL as CFURL,
                           "Invalid CFURL of output PDF: \(outPDF).")
        } catch {
            XCTFail("PDF compression failed: (input: \(inURL), output: \(outURL)).")
        }
    }
    
    


    
    
    
    

}
