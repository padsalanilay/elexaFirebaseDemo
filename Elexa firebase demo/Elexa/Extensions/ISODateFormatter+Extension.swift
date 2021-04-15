//
//  ISODateFormatter+Extension.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import Foundation

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}
