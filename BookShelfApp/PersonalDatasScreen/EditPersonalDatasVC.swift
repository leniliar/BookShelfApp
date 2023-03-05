//
//  EditPersonalDatasVC.swift
//  BookShelfApp
//
//  Created by user on 27.02.23.
//

import Foundation
import UIKit

final class EditPersonalDatasVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var nameTF: UITextField!
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var ageTF: UITextField!
    
    var editDelegate: EditPersonalDatasVCDelegate?
    var editModel = ProfileModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDatePicker()
        nameTF.delegate = self
        emailTF.delegate = self
        ageTF.delegate = self
    }
    
    private func setUpDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        ageTF.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
    }
    
    @objc private func dateDidChange( _ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dataFormatter = DateFormatter()
        
        dataFormatter.dateFormat = "dd.MM.yyyy"
        ageTF.text = dataFormatter.string(from: selectedDate)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTF {
                emailTF.becomeFirstResponder()
            }
        
        if textField == emailTF {
            ageTF.becomeFirstResponder()
        }
        if textField == ageTF {
            ageTF.resignFirstResponder()
        }
            return true
        }
    
    
    @IBAction private func doneDidTap() {
        guard let nameTF = nameTF.text, !nameTF.isEmpty else {return}
        guard let emailTF = emailTF.text, !emailTF.isEmpty else {return}
        guard let ageTF = ageTF.text, !ageTF.isEmpty else {return}
        
        editModel.age = ageTF
        editModel.email = emailTF
        editModel.name = nameTF
        editDelegate?.dataDidSave(model: editModel)
        
        dismiss(animated: true, completion: nil)
        
        
    }
}
