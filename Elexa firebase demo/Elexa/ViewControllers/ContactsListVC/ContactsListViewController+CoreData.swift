//
//  ContactsListViewController+CoreData.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import Foundation
import CoreData

extension ContactsListTableViewController: NSFetchedResultsControllerDelegate {
    
    func getFetchResultsController() -> NSFetchedResultsController<DBContact> {
        let fetchRequest = DBContact.fetchRequest(.all, sortDescriptors: DBContact.nameSortDescriptors)
        
        let context = PersistentContainer.shared.context
        
        let frc = NSFetchedResultsController<DBContact>(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        return frc
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            self.tableView.insertRows(at: [newIndexPath!], with: .automatic)
        }
        else if type == .delete {
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
        }
        else if type == .update {
            self.tableView.reloadRows(at: [indexPath!], with: .automatic)
        }
    }
}
