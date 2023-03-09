//
//  SignInScreenVC.swift
//  BookShelfApp
//
//  Created by user on 3.02.23.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

final class SignInScreenVC: UIViewController, CreateAnAccountDelegate {
    
    func infoDidSave(model: CreateAnAccountModel) {
        if let email = model.email {
            emailTextField.text = email
        }
        if let password = model.password {
            passwordTextField.text = password
        }
    }
    
    
    
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        signInButton.addTarget(self, action:
                               #selector(generateTabBar),
                               for: .touchUpInside)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    
    }
    
    @IBAction private func createAnAccDidTap() {
        let createAnAccountVC = CreateAnAccountVC(nibName: "\(CreateAnAccountVC.self)", bundle: nil)
        createAnAccountVC.createDelegate = self
        createAnAccountVC.createModel = CreateAnAccountModel(email: emailTextField.text,
                                                             password: passwordTextField.text)
        present(createAnAccountVC, animated: true)
    
    }
    
    @IBAction private func signInDidTap() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
        if email.isEmpty && password.isEmpty {
            let alert = UIAlertController(title: "Check your email or password", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    let searchScreen = SearchScreenVC(nibName: "\(SearchScreenVC.self)", bundle: nil)
                    self.navigationController?.pushViewController(searchScreen, animated: true)
                    
                } else {
                    let alert = UIAlertController(title: "Create new account!", message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
    }
       
}
    @objc func generateTabBar() {
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = .black
        
        let searchVC = UINavigationController(rootViewController: SearchScreenVC())
        let profileVC = UINavigationController(rootViewController: PersonalsDatasVC())
        
        tabBar.setViewControllers([generateTabBarVC(viewController: searchVC,
                                                    title: "Search",
                                                    image: UIImage(systemName: "magnifyingglass")),
                                   generateTabBarVC(viewController: profileVC,
                                                    title: "Profile",
                                                    image: UIImage(systemName: "person"))],
                                  animated: false)
        
        func generateTabBarVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
            viewController.tabBarItem.title = title
            viewController.tabBarItem.image = image
            
            return viewController
        }
        tabBar.modalPresentationStyle = .overFullScreen
        
        present(tabBar, animated: false)
    }
    
}

extension SignInScreenVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
                passwordTextField.becomeFirstResponder()
            }
        
        if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
            return true
        }

        
}
