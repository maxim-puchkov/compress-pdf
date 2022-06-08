//
//  main.swift
//  compress-pdf
//
//  Created by Maxim Puchkov on 2020-09-24.
//  Copyright © 2020 Maxim Puchkov. All rights reserved.
//

import PDFCompressor
import ArgumentParser


/// Generate output path in the same directory PDF files.
/// Compressed PDF files are outputted in the same directory as input file with added suffix.
///
/// - Parameters:
///   - inputPath: path of input PDF file.
///   - suffix: output path suffix.
/// - Returns: output path.
func generateOutputPath(_ inputPath: String, withSuffix suffix: String) -> String {
  let url = URL(fileURLWithPath: inputPath, isDirectory: false)
  // Append suffix
  var str = suffix
  if str.isEmpty {
    str = " copy"
  }
  // Append extension (if input file has one)
  if !url.pathExtension.isEmpty {
    str += ".\(url.pathExtension)"
  }
  return "\(url.deletingPathExtension().path)\(str)"
}


/// CLI command `compress-pdf` with flags and options.
struct CompressPDF: ParsableCommand {
  @Flag(name: .shortAndLong,
        help: "Replace original PDF files.")
  var replaceFiles: Bool = false
  
  @Option(name: .shortAndLong,
          help: "Set file suffix added to copied PDF files.")
  var suffix: String = " (compressed)"
  
  @Argument(help: "The PDF files to compress.")
  var files: [String]
  
  mutating func run() throws {
    guard !files.isEmpty else {
      CompressPDF.exit()
    }
    let pdfCompressor = PDFCompressor()
    try files.forEach { (inputPath: String) in
      let outputPath: String
      if replaceFiles {
        outputPath = inputPath
        print("Compressing \(inputPath)")
      } else {
        outputPath = generateOutputPath(inputPath, withSuffix: suffix)
        print("Compressing \(inputPath) -> \(outputPath)")
      }
      // Compress PDF files
      try pdfCompressor.compress(inputPath, out: outputPath)
    }
  }
}

//CommandLine.arguments = [ "compress-pdf", "include-counter", "text", "5.pdf", "/Users/admin/doc.pdf" ]

//CommandLine.arguments = [ "compress-pdf", "--help" ]

CompressPDF.main()
exit(0)




















//import os // ?


// Argument 0 is the name of the executable program.
//let arg0: String = URL(fileURLWithPath: CommandLine.arguments[0], isDirectory: false).lastPathComponent


/// Print to standard error.
///
/// - Parameters:
///   - desc: text describing the error.
///   - prefix: text printed before error description (optional, defaults to name of the program).
/// - Returns: `true` if `data` was written to standard error;
///            `false` otherwise.
//@discardableResult
//func printError(_ desc: String,
//                prefix: String = arg0) -> Bool {
//  let errorText = "\(prefix): \(desc)\n"
//  guard let errorData = errorText.data(using: .utf8) else {
//    return false
//  }
//  FileHandle.standardError.write(errorData)
//  return true
//}



/// Validate PDF file path.
///
/// - Parameter path: path of file.
/// - Returns: `true` if `path` refers to the location of a PDF document;
///            `false` otherwise.
//func isValidPath(_ path: String) -> Bool {
//  let url = URL(fileURLWithPath: path)
//  guard let _ = PDFDocument(url: url) else {
//    return false
//  }
//  return true
//}













//
//
//  do {
//    print("in \(inputPath), out: \(outputPath)")
//    try pdfCompressor.compress(inputPath, out: outputPath)
//  } catch {
//    printError("error: \(error)")
//  }

//}
