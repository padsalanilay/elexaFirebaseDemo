//
//  Date+Extension.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import Foundation

extension Date {
    var iso8601withFractionalSeconds: String { return Formatter.iso8601withFractionalSeconds.string(from: self) }
}
