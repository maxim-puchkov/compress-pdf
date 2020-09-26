//
//  main.swift
//  compress-pdf
//
//  Created by Maxim Puchkov on 2020-09-24.
//  Copyright © 2020 Maxim Puchkov. All rights reserved.
//

import PDFCompressor
import os


/// Print to standard error.
///
/// - Parameter errorDescription: text describing the error.
/// - Returns: `true` if `data` was written to standard error;
///            `false` otherwise.
@discardableResult
func printError(_ errorDescription: String) -> Bool {
  let standardError = FileHandle.standardError
  guard let data = errorDescription.data(using: .utf8) else {
    return false
  }
  standardError.write(data)
  return true
}


/// Validate PDF file path.
///
/// - Parameter path: path of file.
/// - Returns: `true` if `path` refers to the location of a PDF document;
///            `false` otherwise.
func isValidPath(_ path: String) -> Bool {
  let url = URL(fileURLWithPath: path)
  guard let _ = PDFDocument(url: url) else {
    return false
  }
  return true
}




guard (CommandLine.argc == 3) else {
  printError("usage: ") //TODO: Usage
  exit(2)
}



let inputPath = CommandLine.arguments[1]
let outputPath = CommandLine.arguments[2]
print(inputPath, outputPath)

let pdfCompressor = PDFCompressor()
//try pdfCompressor.compress(inputPath, out: outputPath)

exit(0)




// Path to input and output files
//let inFilePath  = "/Users/admin/01-test.pdf" // 9.5 MB
//let outFilePath = "/Users/admin/out-01.pdf" // 321 KB


// Try to compress the input file
//do {
//  let compressor = try PDFCompressor()!
//  try compressor.compress(inFilePath, out: outFilePath)
//} catch {
//  print("Error: \(error).")
//  exit(1)
//}


