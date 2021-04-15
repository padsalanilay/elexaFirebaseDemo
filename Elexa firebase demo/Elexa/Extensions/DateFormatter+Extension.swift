//
//  DateFormatter+Extension.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import Foundation

extension Formatter {
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}
