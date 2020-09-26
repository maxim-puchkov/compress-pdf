//
//  main.swift
//  compress-pdf
//
//  Created by Maxim Puchkov on 2020-09-24.
//  Copyright © 2020 Maxim Puchkov. All rights reserved.
//

import Foundation
import PDFCompressor


// Path to input and output files
let inFilePath  = "/Users/admin/01-test.pdf" // 9.5 MB
let outFilePath = "/Users/admin/out-01.pdf" // 321 KB


// Try to compress the input file
do {
  let compressor = try PDFCompressor()!
  try compressor.compress(inFilePath, out: outFilePath)
} catch {
  print("Error: \(error).")
}





//do {
//  let compressor = try PDFCompressor.init(filter: "Compress-PDF")
//  let outURL: CFURL = compressor.compress(inFilePath, out: outFilePath)
//  print("Compressed PDF document: \(outURL).")
//} catch {
//  print(error)
//}
//
//print("Hello, World!")


