//
//  String+Date.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import Foundation

extension String {
    var iso8601withFractionalSeconds: Date? { return Formatter.iso8601withFractionalSeconds.date(from: self) }
}
