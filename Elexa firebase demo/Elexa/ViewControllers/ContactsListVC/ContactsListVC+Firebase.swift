//
//  ContactsListVC+Firebase.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/10/21.
//

import Foundation
import Firebase

extension ContactsListTableViewController {
    func observeQuery() {
      guard let query = query else { return }
      stopObserving()

      // Display data from Firestore

        //load query for firebase
      listener = query.addSnapshotListener { (snapshot, error) in
        guard let snapshot = snapshot else {
          print("Error fetching snapshot results: \(error!)")
          return
        }
        
        // get snapshot documents and convert them into app data
        let _ = snapshot.documents.map { (document) -> Contact in
          let maybeModel: DTContact?
          do {
            let data = try JSONSerialization.data(withJSONObject: document.data(), options: .prettyPrinted)
            maybeModel = try JSONDecoder().decode(DTContact.self, from: data)
          } catch {
            // Don't use fatalError here in a real app.
           fatalError("Unable to initialize type \(DTContact.self) with dictionary \(document.data()): \(error)")
          }

          if let model = maybeModel {
            return Contact(dtContact: model)
          } else {
            // Don't use fatalError here in a real app.
            fatalError("Missing document of type \(DTContact.self) at \(document.reference.path)")
          }
        }

      }
    }

    // stop firebase observer
    func stopObserving() {
      listener?.remove()
    }

    // Firebase query for
    func baseQuery() -> Query {
      return Firestore.firestore().collection("contacts")//.limit(to: 5)
    }

    func deleteContactOnFireBase(with id: String, completion: @escaping ()-> Void) {
        Firestore.firestore().collection("contacts").document(id)
            .delete() { err in
                if let _ = err {
                    print("Error removing document")
                } else {
                    completion()
                }
            }
    }
}
