//
//  PDFCompressor.swift
//  compress-pdf
//
//  Created by Maxim Puchkov on 2020-09-24.
//  Copyright © 2020 Maxim Puchkov. All rights reserved.
//

import Quartz

public enum PDFCompressionError : Error {
  case QuartzFilterNotFound(String);
}


class PDFFilter {
  
}


/**
 PDFCompressor reduces size of Portable Document Format (PDF) files by
 applying a JPEG compression quartz filter to a copy of the input file.
 */
public class PDFCompressor {
  
  /// Name of the default filter (currently the only filter)
  public static let kDefaultFilter: String = "Compress PDF"
  
  public static func getFilter(filter name: String) -> QuartzFilter {
    let ext = "qfilter"
    let dir = "PDFCompressor.framework/Resources"
    guard let filterURL = Bundle.main.url(forResource: name,
                                          withExtension: ext,
                                          subdirectory: dir) else {
      exit(1)
    }
    return QuartzFilter(url: filterURL)
  }
  
  
  
  /// Quartz filter that is applied to PDF documents.
  private let quartz_filter: QuartzFilter
  
  public var filter: String {
    get {
      return quartz_filter.localizedName()
//      return self.quartz_filter.url()!.absoluteString
    }
  }
  
  public init() {
    self.quartz_filter = Self.getFilter(filter: Self.kDefaultFilter)
  }
  
  
  /// Create a PDFCompressor with the specified quartz filter.
  /// If filter name is not provided, the default filter will be used
  ///
  /// - Parameter name: (Optional) The name of the Quartz Filter to be used for compression.
  public init(filter name: String = kDefaultFilter) throws {
    self.quartz_filter = Self.getFilter(filter: name)
//    do {
//      self.quartz_filter = try QuartzFilter(resource: name)
//    }
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
    self.quartz_filter.apply(to: outPDF)
    
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
