//
//  ContactsListTableViewController.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import UIKit
import CoreData
import Firebase

class ContactsListTableViewController: UITableViewController {

    private var SegueId = "showContactDetails"
    lazy var fetchResultsController: NSFetchedResultsController<DBContact> = self.getFetchResultsController()
        
    var query: Query? {
      didSet {
        if let listener = listener {
          listener.remove()
          observeQuery()
        }
      }
    }
    
    var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        query = baseQuery()
        observeQuery()
        self.loadDatabaseContacts()
    }

    deinit {
        stopObserving()
        listener?.remove()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactcell", for: indexPath)
        
        let contact = fetchResultsController.object(at: indexPath)
        cell.textLabel?.text = "\(contact.firstName!) \(contact.lastName!)"
        
        return cell
    }

    // Conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteContact(at: indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    
    // Select contact prepare detail view segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId {
            guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
            
            let contact = self.fetchResultsController.object(at: selectedIndex)
            let detailsVC = segue.destination as! ContactDetailsViewController
            detailsVC.contactID = contact.uid
        }
    }

}
