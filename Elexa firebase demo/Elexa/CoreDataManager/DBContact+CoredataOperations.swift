//
//  DBContact+CoredataOperations.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/12/21.
//

import Foundation
import CoreData

extension DBContact {
    /// Loads contact for given id
    /// - Parameter id: Unique id for contact
    /// - Returns: Contact with given id or nil
    static func load(for id: String) -> DBContact? {
        let context = PersistentContainer.shared.context
        let request = fetchRequest(ID_PREDICATE(id))
        
        let contacts = try? context.fetch(request)
        
        return contacts?.first
    }
    
    /// Creates fetchrequest
    /// - Parameter predicate: NSPredicate for the fetch request
    /// - Returns: Fetch request with the given predicate
    static func fetchRequest(_ predicate: NSPredicate, sortDescriptors: [NSSortDescriptor] = []) -> NSFetchRequest<DBContact> {
        let request = NSFetchRequest<DBContact>(entityName: "DBContact")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        return request
    }
    
    static func update(for contact: Contact) {
        let context = PersistentContainer.shared.context
        
        let oldDBContact = Self.load(for: contact.uid)
        let dbContact = oldDBContact ?? DBContact(context: context)
        
        if oldDBContact != dbContact { dbContact.uid = contact.uid }
        
        dbContact.firstName = contact.firstName
        dbContact.lastName = contact.lastName
        dbContact.phone = contact.phone
        dbContact.email = contact.email
        dbContact.department = contact.department.rawValue
        dbContact.favoriteColor = contact.favoriteColor
        dbContact.createdAt = contact.createdAt
        
        try? context.save()
    }
        
    // MARK:- Predicates for contacts
    static func ID_PREDICATE(_ id: String) -> NSPredicate { NSPredicate(format: "uid == %@", id) }
    
    // MARK:- Sort descriptors for contacts
    static let nameSortDescriptors = [NSSortDescriptor(key: #keyPath(DBContact.firstName), ascending: true), NSSortDescriptor(key: #keyPath(DBContact.lastName), ascending: true)]
}
