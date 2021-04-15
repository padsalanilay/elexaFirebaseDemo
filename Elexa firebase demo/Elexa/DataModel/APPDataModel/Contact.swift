//
//  Contact.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import Foundation

struct Contact {
    var uid: String
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var favoriteColor: String
    var department: Department
    var createdAt: Date?
    
    init(dtContact: DTContact) {
        self.uid = dtContact.uid
        self.firstName = dtContact.firstName
        self.lastName = dtContact.lastName
        self.email = dtContact.email
        self.phone = dtContact.phone
        self.favoriteColor = dtContact.favoriteColor
        self.department = Department(rawValue: dtContact.department) ?? Department.Unkown
        self.createdAt = dtContact.createdAt.iso8601withFractionalSeconds
        
        DBContact.update(for: self)
    }
}

enum Department: String, CaseIterable {
    case Unkown
    case HR
    case Marketing
    case Development
    case Operations
    case Sales
}

