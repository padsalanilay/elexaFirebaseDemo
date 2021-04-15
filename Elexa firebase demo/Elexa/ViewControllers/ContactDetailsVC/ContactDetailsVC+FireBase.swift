//
//  Temp3.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import Foundation
import Firebase

extension ContactDetailsViewController {
    
    func updateContactDetailsOnFireBase(completion: @escaping () -> Void) {
        Firestore.firestore().collection("contacts").document(self.contactID!)
            .updateData(getContactData()) { err in
                if let _ = err {
                    self.showAlert(for: "Error updating document")
                }
                else {
                    self.configureView()
                    completion()
                }
            }
    }
    
    func addNewContactToFireBase(completion: @escaping () -> Void) {
        
        Firestore.firestore().collection("contacts").addDocument(data: getContactData()){ (err) in
            if let _ = err {
                self.showAlert(for: "Error updating document")
            }
            else {
                self.configureView()
                completion()
            }
        }
    }
    
    func getContactData() -> [String: String] {
        return ["firstName": self.firstNameTF.text!,
                "lastName": self.lastNameTF.text!,
                "phone": self.phoneNumberTF.text!,
                "email": self.emailTF.text!,
                "favoriteColor": self.favoriteColorLBL.text!,
                "department": self.departmentLBL.text!
            ]
    }
}
