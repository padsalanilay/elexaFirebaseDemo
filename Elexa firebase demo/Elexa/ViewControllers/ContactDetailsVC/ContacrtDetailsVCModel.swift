//
//  temp2.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import Foundation
import UIKit

extension ContactDetailsViewController {
    func loadDatabaseContact() {
        do {
            try self.fetchResultsController.performFetch()
        }
        catch let error {
            print(error)
        }
        
        self.tableView.reloadData()
    }
        
    func updateContact() {
        if hasContactDetailsChanged() {
            if hasValidContactData() {
                self.updateContactDetailsOnFireBase {
//                    self.updateContactInDB()
                }
            }
            else {
                self.showAlert(for: "Enter valid contact data")
            }
        }
    }
    
    func addNewContact() {
        if hasValidContactData() {
            self.addNewContactToFireBase {
                self.dismiss(animated: true, completion: nil)
            }
        }
        else {
            self.showAlert(for: "Enter valid contact data")
        }
    }
    
    func hasContactDetailsChanged() -> Bool{
        return self.firstNameTF.text != contact?.firstName ||
           self.lastNameTF.text != contact?.lastName ||
           self.phoneNumberTF.text != contact?.phone ||
            self.emailTF.text != contact?.email ||
           self.departmentLBL.text != contact?.department ||
           self.favoriteColorLBL.text != contact?.favoriteColor
    }
    
    func showAlert(for message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func hasValidContactData() -> Bool {
        return !(self.firstNameTF.text == "" ||
        self.lastNameTF.text == "" ||
        self.emailTF.text == "" ||
        self.phoneNumberTF.text == "" ||
        self.departmentLBL.text == "Unknown" ||
        self.firstNameTF.text == "Unknown")
    }
    
    
}
