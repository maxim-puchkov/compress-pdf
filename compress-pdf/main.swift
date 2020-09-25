//
//  main.swift
//  compress-pdf
//
//  Created by Maxim Puchkov on 2020-09-24.
//  Copyright © 2020 Maxim Puchkov. All rights reserved.
//

import Foundation
//import Quartz






let inFilePath  = "/Users/admin/01-test.pdf"
let outFilePath = "/Users/admin/out-01.pdf"
let compressor = PDFCompressor.init(filter: "Compress-PDF")

let outURL: CFURL = compressor.compress(inFilePath, out: outFilePath)
print("Compressed PDF document: \(outURL).")
print("Hello, World!")



/*
// Test
let testPath = "/Users/admin/test-output.pdf"
let testURL = URL(fileURLWithPath: testPath)


let testPdf = PDFDocument(url: URL(fileURLWithPath: inFilePath))!
let page1 = testPdf.documentRef!.page(at: 1)!
let page2 = testPdf.documentRef!.page(at: 2)!
var box1 = page1.getBoxRect(.mediaBox)
var box2 = page2.getBoxRect(.mediaBox)


//var box1 = CGRect(x: 0, y: 0, width: 1855, height: 2497)
//var box2 = CGRect(x: 0, y: 0, width: 612, height: 792)


let c = CGContext(testURL as CFURL, mediaBox: nil, nil)!


c.beginPage(mediaBox: &box1)
c.drawPDFPage(page1)
c.endPage()


c.beginPage(mediaBox: &box2)
c.drawPDFPage(page2)
c.endPage()
c.closePDF()

let aux = [ kCGPDFContextMediaBox: box1 ] as CFDictionary
//c.beginPDFPage(aux)

//c.drawPDFPage()
//c.endPDFPage()


//let aux2 = [ kCGPDFContextMediaBox: box2 ] as CFDictionary

//c.beginPDFPage(aux2)
//c.drawPDFPage()
//c.endPDFPage()
//c.closePDF()
*/
