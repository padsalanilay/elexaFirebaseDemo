//
//  ContactDetailsViewController.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import UIKit
import CoreData

class ContactDetailsViewController: UITableViewController {

    // contact details
    @IBOutlet weak var departmentLBL: UILabel!
    @IBOutlet weak var favoriteColorLBL: UILabel!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!

    // edit button
    @IBOutlet weak var departmentPickerCell: UITableViewCell!
    @IBOutlet weak var departmentPicker: UIPickerView!
    var isDepartmentPickerHidden: Bool = true
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    // table view cell
    @IBOutlet weak var saveContactCell: UITableViewCell!

    // contact referense (uid)
    var contactID: String?
    var contactEditing: Bool = false
    lazy var fetchResultsController: NSFetchedResultsController<DBContact> = self.getFetchResultsController()
    
    var contact: DBContact? {
        if let contacts = fetchResultsController.fetchedObjects, contacts.count > 0
        {
            return fetchResultsController.object(at: IndexPath(row: 0, section: 0))
        }
        return nil
    }
    
    var isPresented: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isPresented = self.presentingViewController?.presentedViewController == self
                || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
        // showing contact details
        if !self.isPresented {
            // load contact from db
            self.loadDatabaseContact()
            
            // setup view for editing
            self.setUPView()
        }
        else {
            self.isDepartmentPickerHidden = false
            self.tableView.reloadData()
        }
        self.isEditing = self.isPresented
        
        // set contact data to ui
        self.configureView()
        
        // set pickerview for department
        self.setPickerView()
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        self.isEditing.toggle()
        self.editButton.title = self.isEditing ? "Cancel" : "Edit"
        self.setUPView()
    }
        
    @IBAction func saveContactClicked(_ sender: Any) {
        if !isPresented {
            self.updateContact()
        }
        else {
            self.addNewContact()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 && indexPath.row == 1 {
            if self.isDepartmentPickerHidden { return 0 }
            return 153
        }
        
        if indexPath.section == 0 { return 100 }
        
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && indexPath.row == 0 {
            self.isDepartmentPickerHidden.toggle()
            self.tableView.reloadData()
        }
    }
    func configureView() {
        self.firstNameTF.text = contact?.firstName ?? ""
        self.lastNameTF.text = contact?.lastName ?? ""
        self.emailTF.text = contact?.email ?? ""
        self.phoneNumberTF.text = contact?.phone ?? ""
        self.departmentLBL.text = contact?.department ?? Department.Unkown.rawValue
        self.favoriteColorLBL.text = contact?.favoriteColor ?? "Unkown"
    }
    
    private func setUPView() {
        self.firstNameTF.isUserInteractionEnabled = self.isEditing
        self.lastNameTF.isUserInteractionEnabled = self.isEditing
        self.emailTF.isUserInteractionEnabled = self.isEditing
        self.phoneNumberTF.isUserInteractionEnabled = self.isEditing
        self.departmentLBL.isUserInteractionEnabled = self.isEditing
        self.favoriteColorLBL.isUserInteractionEnabled = self.isEditing
        self.saveContactCell.isHidden =  !self.isPresented || !self.isEditing
    }
    
}
