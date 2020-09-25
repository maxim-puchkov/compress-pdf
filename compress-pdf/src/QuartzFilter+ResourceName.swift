//
//  QuartzFilter+ResourceName.swift
//  compress-pdf
//
//  Created by Maxim Puchkov on 2020-09-25.
//  Copyright © 2020 com.maximpuchkov. All rights reserved.
//

import Quartz


extension QuartzFilter {
  
  /// Load filter by the specified name from `Resources/Filters` directory
  /// - Parameter resource: name of quartz filter resource file
  public convenience init!(resource name: String) {
    guard let url = Bundle.main.url(forResource:   name,
                                    withExtension: "qfilter",
                                    subdirectory:  "Filters") else {
      print("Quartz filter resource file not found: \(name).")
      exit(1)
    }
    self.init(url: url)
  }
  
}
