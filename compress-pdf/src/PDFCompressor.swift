//
//  PDFCompressor.swift
//  compress-pdf
//
//  Created by Maxim Puchkov on 2020-09-24.
//  Copyright © 2020 Maxim Puchkov. All rights reserved.
//

import Quartz


/**
 PDFCompressor reduces size of Portable Document Format (PDF) files by
 applying a JPEG compression quartz filter to a copy of the input file.
 */
public class PDFCompressor {
  
  /// Name of the default filter (currently the only filter)
  public static let kDefaultQuartzFilter: String = "Compress-PDF"
  
  /// Quartz filter that is applied to PDF documents.
  private let qfilter: QuartzFilter
  
  
  
  /// Create a PDFCompressor with the specified quartz filter.
  /// If filter name is not provided, the default filter will be used
  ///
  /// - Parameter name: (Optional) The name of the Quartz Filter to be used for compression.
  public init(filter name: String = kDefaultQuartzFilter) {
    self.qfilter = QuartzFilter(resource: name)
  }
  
  
  
  //
  public func compress(_ inPath: String, out outPath: String) -> CFURL {
    let inURL = URL(fileURLWithPath: inPath)
    let outURL = URL(fileURLWithPath: outPath)
    return self.compress(inURL, out: outURL)
  }
  
  
  //
  public func compress(_ inURL: URL, out outURL: URL) -> CFURL {
    // Make sure input PDF file at 'inURL' is valid
    guard let inFile = PDFDocument(url: inURL) else {
      print("Invalid input URL: \(inURL.description).")
      exit(1)
    }
    
    // Get original input PDF document at 'inURL'
    let inPDF: CGPDFDocument = inFile.documentRef!
    // Create an empty PDF document at 'outURL'
    let outPDF: CGContext = CGContext(outURL as CFURL, mediaBox: nil, nil)!
    
    // Apply the compression filter to output document. The filter will
    // process all data between 'stream' and 'endstream' PDF keywords.
    self.qfilter.apply(to: outPDF)
    
    // Copy every page to new output document
    for index in 1...inPDF.numberOfPages {
      // Get current page and its size (bounds) from input document
      let page: CGPDFPage = inPDF.page(at: index)!
      var pageMediaBox: CGRect = page.getBoxRect(.mediaBox)
      
      // Redraw current page in output document
      outPDF.beginPage(mediaBox: &pageMediaBox)
      outPDF.drawPDFPage(page)
      outPDF.endPage()
    }
    // Close output document and return its location
    outPDF.closePDF()
    return (outURL as CFURL)
  }
  
}


  
  /*
  /// Copy the PDF document from `input` location and apply the quartz filter to the copied data.
  /// The resulting PDF file is written to the `output` location.
  public func compress(_ inURL: URL, out outURL: URL) {
    let inFile = PDFDocument(url: inURL)!
    
    var box = inFile.documentRef!.page(at: 1)!.getBoxRect(.mediaBox)
    

    
    let outFile = CGContext(outURL as CFURL,
                            mediaBox: &box, nil)!
//                            aux as CFDictionary)!
    for index in 1...inFile.pageCount {
      let inPage = inFile.documentRef!.page(at: index)!
      self.qfilter.apply(to: outFile)
      outFile.beginPDFPage(nil)
      outFile.drawPDFPage(inPage)
      outFile.endPDFPage()
    }
//    outFile.closePDF()
    
    
//    let document
//    let media =
//    let outputFile = CGContext(outURL as CFURL, mediaBox: media, nil)
//    print(inputFile)
    //qfilter.apply(to: )
  }
  */
