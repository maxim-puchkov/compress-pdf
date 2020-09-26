//
//  PDFCompressor.swift
//  compress-pdf
//
//  Created by Maxim Puchkov on 2020-09-24.
//  Copyright © 2020 Maxim Puchkov. All rights reserved.
//

import Quartz

public enum PDFCompressionError : Error {
  case NoSuchQuartzFilter(filterName: String);
  case NoSuchFile(fileURL: URL)
}


/**
 PDFCompressor reduces size of Portable Document Format (PDF) files by
 applying a JPEG compression quartz filter to a copy of the input file.
 */
public class PDFCompressor {
  
  /// Name of the default filter (currently the only filter)
  public static let kDefaultFilterName: String = "Compress PDF"
  
  public static func getFilterURL(filter name: String) -> URL? {
    let ext = "qfilter"
    let dir = "Resources"
    let bundle = Bundle(for: self)
    return bundle.url(forResource: name,
                      withExtension: ext,
                      subdirectory: dir)
  }
  
  
  
  /// Quartz filter that is applied to PDF documents.
  private let quartz_filter: QuartzFilter
  /// Name of the PDF compression filter.
  public var filter: String {
    get {
      return quartz_filter.localizedName()
    }
  }
  

  /// Create a PDFCompressor with the specified quartz filter.
  /// If filter name is not provided, the default filter will be used
  ///
  /// - Parameter name: (Optional) The name of the Quartz Filter to be used for compression.
  public init!(filter name: String = kDefaultFilterName) throws {
    guard let filterURL = Self.getFilterURL(filter: name) else {
      throw PDFCompressionError.NoSuchQuartzFilter(filterName: name)
    }
    self.quartz_filter = QuartzFilter(url: filterURL)
  }
  
  
  
  //
  public func compress(_ inPath: String, out outPath: String) throws -> CFURL {
    let inURL = URL(fileURLWithPath: inPath)
    let outURL = URL(fileURLWithPath: outPath)
    return try self.compress(inURL, out: outURL)
  }
  
  
  //
  public func compress(_ inURL: URL, out outURL: URL) throws -> CFURL {
    // Make sure input PDF file at 'inURL' is valid
    guard let inFile = PDFDocument(url: inURL) else {
      throw PDFCompressionError.NoSuchFile(fileURL: inURL)
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
