//
//  SreateAnAccountVC.swift
//  BookShelfApp
//
//  Created by user on 3.02.23.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

final class CreateAnAccountVC: UIViewController {
    
    let emailValidType: String.ValidityType = .email
    let passwordValidType: String.ValidityType = .password
    let repeatPasswordValidType: String.ValidityType = .password
    
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var repeatPasswordTF: UITextField!
    @IBOutlet private weak var validEmailLabel: UILabel!
    @IBOutlet private weak var validPasswordLabel: UILabel!
    @IBOutlet private weak var repeatPasswordLabel: UILabel!
    
    var createDelegate: CreateAnAccountDelegate?
    var createModel = CreateAnAccountModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validEmailLabel.isHidden = true
        validPasswordLabel.isHidden = true
        repeatPasswordLabel.isHidden = true
        emailTF.delegate = self
        passwordTF.delegate = self
        repeatPasswordTF.delegate = self
    }
    
    private func setTextField (textField: UITextField, label: UILabel,validType: String.ValidityType, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        textField.text = result
        
        if result.textfieldIsValid(validType) {
            label.text = validMessage
            label.textColor = UIColor(red: 20/255, green: 101/255, blue: 88/255, alpha: 1)
            label.isHidden = false
        } else {
            label.text = wrongMessage
            label.textColor = UIColor(red: 92/255, green: 30/255, blue: 23/255, alpha: 1)
            label.isHidden = false
        }
        
    }
    
    
    
    
    @IBAction private func createAnAccountDidTap() {
        guard let textEmail = emailTF.text else {return}
        guard let textPassword = passwordTF.text else {return}
        createModel.email = textEmail
        createModel.password = textPassword
        createDelegate?.infoDidSave(model: createModel)
        
        if !textEmail.isEmpty && !textPassword.isEmpty {
            Auth.auth().createUser(withEmail: textEmail, password: textPassword) { (result, error) in
                if error == nil {
                    if let result = result {
                        print(result.user.uid)
                        let base = Database.database().reference().child("users")
                        base.child(result.user.uid).updateChildValues(["textEmail" : textEmail, "textPassword":  textPassword ])
                        
                    }
                }
            }
        }
        
        dismiss(animated: true)
    }
}


extension CreateAnAccountVC: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case emailTF: setTextField(textField: emailTF,
                                   label: validEmailLabel,
                                   validType: emailValidType,
                                   validMessage: "Correct email",
                                   wrongMessage: "Check your email!",
                                   string: string,
                                   range: range)
            
        case passwordTF: setTextField(textField: passwordTF,
                                      label: validPasswordLabel,
                                      validType: passwordValidType,
                                      validMessage: "Correct password",
                                      wrongMessage: "8 characters long, minimum one uppercase letter, one special character",
                                      string: string,
                                      range: range)
        case repeatPasswordTF: setTextField(textField: repeatPasswordTF,
                                            label: repeatPasswordLabel,
                                            validType: repeatPasswordValidType,
                                            validMessage: "Correct password",
                                            wrongMessage: " ",
                                            string: string,
                                            range: range)
        default:
            break
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTF {
            if emailTF.text != "" {
                passwordTF.becomeFirstResponder()
            } else {
                validEmailLabel.isHidden = false
                validEmailLabel.text = "Email text field is empty!"
                validEmailLabel.textColor = UIColor(red: 92/255, green: 30/255, blue: 23/255, alpha: 1)
            }
        }
        if textField == passwordTF {
            if passwordTF.text != "" {
                repeatPasswordTF.becomeFirstResponder()
            } else {
                validPasswordLabel.isHidden = false
                validPasswordLabel.text = "Password text field is empty!"
                validPasswordLabel.textColor = UIColor(red: 92/255, green: 30/255, blue: 23/255, alpha: 1)
            }
        }
        if textField == repeatPasswordTF {
            if repeatPasswordTF.text?.isEmpty != nil && repeatPasswordTF.text == passwordTF.text{
                                repeatPasswordLabel.isHidden = false
                                repeatPasswordLabel.text = "Correct password!"
                                repeatPasswordLabel.textColor = UIColor(red: 20/255, green: 101/255, blue: 88/255, alpha: 1)
                            } else {
                                repeatPasswordLabel.isHidden = false
                                repeatPasswordLabel.text = "Wrong password!"
                                repeatPasswordLabel.textColor = UIColor(red: 92/255, green: 30/255, blue: 23/255, alpha: 1)
                            }
                                repeatPasswordTF.resignFirstResponder()
            }
            return true
        }
        
        
}
    

