//
//  ContactsListViewModel.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import Foundation

extension ContactsListTableViewController {
    func loadDatabaseContacts() {
        do {
            try self.fetchResultsController.performFetch()
        }
        catch let error {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    func deleteContact(at indexPath: IndexPath) {
        let contact = self.fetchResultsController.object(at: indexPath)
        let contactId = contact.uid!
        self.deleteContactOnFireBase(with: contactId) {
            PersistentContainer.shared.context.delete(contact)
            PersistentContainer.shared.saveContext()
        }
    }
}
