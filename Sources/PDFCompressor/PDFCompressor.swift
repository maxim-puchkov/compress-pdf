//
//  PDFCompressor.swift
//  compress-pdf
//
//  Created by Maxim Puchkov on 2020-09-24.
//  Copyright © 2020 Maxim Puchkov. All rights reserved.
//

import Foundation
import Quartz

/**
 PDFCompressor reduces size of Portable Document Format (PDF) files by
 applying a JPEG compression quartz filter to a copy of the input file.
 */
public class PDFCompressor {

  /// File name of the default filter (currently the only filter).
  public static let kDefaultFilterName: String = "Compress PDF"

  /// Search framework resources for quartz filter specified by its name.
  ///
  /// - Parameter filterName: name of a bundled quartz filter.
  public static func getFilterURL(name filterName: String) -> URL? {
    let ext = "qfilter"
    return Bundle.module.url(forResource: filterName,
                             withExtension: ext)
  }





  /// Quartz filter will be applied to data between 'stream' and 'endstream' PDF keywords.
  private let quartz_filter: QuartzFilter

  /// Quartz filter's localized display name.
  public var filter: String {
    get { return self.quartz_filter.localizedName() }
  }





  /// Create a PDF compressor with default filter.
  public convenience init() {
    let filterURL = Self.getFilterURL(name: Self.kDefaultFilterName)!
    self.init(url: filterURL)
  }


  /// Create a PDFCompressor with quartz filter specified by its name.
  /// If filter name is not provided, the default filter will be used.
  ///
  /// - Parameter filterName: name of quartz filter to be used for compression (optional).
  /// - Throws: `PDFCompressionError.QuartzFilterNotFoundError`
  ///            if quartz  filter named `filterName` is not found.
  public convenience init!(name filterName: String = kDefaultFilterName) throws {
    guard let filterURL = Self.getFilterURL(name: filterName) else {
      throw PDFCompressionError.QuartzFilterNotFoundError(filterName: filterName)
    }
    self.init(url: filterURL)
  }


  /// Create a PDFCompressor with quartz filter specified by its URL.
  ///
  /// - Parameter filterURL: location of quartz filter to be used for compression.
  private init(url filterURL: URL) {
    self.quartz_filter = QuartzFilter(url: filterURL)
  }





  /// Apply compression filter to PDF document.
  ///
  /// - Parameters:
  ///   - inPath:  path to the input PDF file.
  ///   - outPath: path where output PDF file will be written to.
  /// - Throws: `PDFCompressionError.PDFFileNotFoundError`
  ///            if PDF file at `inPath` is not found.
  /// - Returns: location of output document context.
  @discardableResult
  public func compress(_ inPath: String, out outPath: String) throws -> CFURL {
    let inURL = URL(fileURLWithPath: inPath)
    let outURL = URL(fileURLWithPath: outPath)
    return try self.compress(inURL, out: outURL)
  }


  /// Apply compression filter to PDF document.
  ///
  /// - Parameters:
  ///   - inURL:  location of the input PDF file.
  ///   - outURL: location where output PDF file will be written to.
  /// - Throws: `PDFCompressionError.PDFFileNotFoundError`
  ///            if PDF file at `inURL` is not found.
  /// - Returns: location of output document context.
  @discardableResult
  public func compress(_ inURL: URL, out outURL: URL) throws -> CFURL {
    // Make sure input PDF file at 'inURL' is valid
    guard let inFile = PDFDocument(url: inURL) else {
      throw PDFCompressionError.PDFFileNotFoundError(fileURL: inURL.absoluteURL)
    }

    // Get original input PDF document at 'inURL'
    let inPDF: CGPDFDocument = inFile.documentRef!
    // Create an empty PDF document at 'outURL'
    let outPDF: CGContext = CGContext(outURL as CFURL, mediaBox: nil, nil)!

    // All PDF pages drawn after the filter is applied will be compressed
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
