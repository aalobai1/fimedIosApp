//
//  SignUpViewController.swift
//  aToastie
//
//  Created by Ali Alobaidi on 10/5/19.
//  Copyright © 2019 Ali Alobaidi. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    var email: String!
    var password: String!
    var confirmedPassword: String!

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var confirmedPasswordtext: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createAnAccountPressed(_ sender: UIButton) {
        getUserInput()
        if email.count > 0 && password.count > 0 && confirmedPassword.count > 0 {
            let passwordConfirmed = checkPassword(password: password, confirmedPassword: confirmedPassword)
            if passwordConfirmed {
                let user = User(email: email, password: password)
                user.signUp(completion: goToNextScreen)
            }
        }
    }
    
    func goToNextScreen(error: Error?, user: AuthDataResult?) {
        if error != nil {
            alert(message: error!.localizedDescription, title: "Oops something wen't wrong")
        } else if user != nil {
            performSegue(withIdentifier: "goToHomeScreen", sender: nil)
        }
    }
    
   
    func getUserInput() {
        if let email = emailTextField.text,
            let password = passwordtextField.text,
            let confirmedPassword = passwordtextField.text {
                self.email = email
                self.password = password
                self.confirmedPassword = confirmedPassword
        }
    }
}

extension SignUpViewController {
    
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
    
  func checkPassword(password: String, confirmedPassword: String) -> Bool {
           return password == confirmedPassword
  }
    
}
