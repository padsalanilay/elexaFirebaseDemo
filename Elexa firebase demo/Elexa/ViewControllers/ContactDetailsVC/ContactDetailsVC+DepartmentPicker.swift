//
//  ContactDetailsVC+DepartmentPicker.swift
//  Elexa
//
//  Created by Nilay Padsala on 4/12/21.
//

import Foundation
import UIKit

extension ContactDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func setPickerView() {
        departmentPicker.delegate = self
        departmentPicker.dataSource = self
        let department: Department = Department(rawValue: contact?.department ?? "") ?? .Unkown
        departmentPicker.selectRow(Department.allCases.firstIndex(of: department)!, inComponent: 0, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Department.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Department.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.isEditing { self.departmentLBL.text = Department.allCases[row].rawValue }
    }
}
