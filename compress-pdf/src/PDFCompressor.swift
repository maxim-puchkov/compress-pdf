//
//  PDFCompressor.swift
//  compress-pdf
//
//  Created by Maxim Puchkov on 2020-09-24.
//  Copyright © 2020 Maxim Puchkov. All rights reserved.
//

import Quartz


/**
 PDFCompressor generates compressed Portable Document Format (PDF) files by
 applying a quartz filter with JPEG compression to a __copy__ of the input file.
 */
public class PDFCompressor {
  
  /// Name of the default filter (currently the only filter)
  public static let kDefaultQuartzFilter: String = "Compress-PDF"
  
  /// Quartz filter that is applied to PDF documents.
  private let qfilter: QuartzFilter
  
  
  
  //MARK: - Init
  /// Create a default PDF compressor.
  public convenience init() {
    self.init(filter: Self.kDefaultQuartzFilter)
  }
  
  /// Create a PDF compressor with filter specified by name.
  /// - Parameter name: The name of the Quartz Filter to be used for compression.
  public init(filter name: String) {
    guard let url = Bundle.main.url(forResource:   name,
                                    withExtension: "qfilter",
                                    subdirectory:  "Filters")
    else {
      //FIXME: print to stderr
      print("Quartz Filter named \"" + name + "\" could not be found.")
      exit(1)
    }
    self.qfilter = QuartzFilter(url: url)
  }
  // MARK: Init -
  
  
  
  /// Copy the PDF document from `input` location and apply the quartz filter to the copied data.
  /// The resulting PDF file is written to the `output` location.
  public func compress(input: URL, output: URL) {
    //qfilter.apply(to: )
  }
  
}
