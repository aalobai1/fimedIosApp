//
//  LoginViewController.swift
//  aToastie
//
//  Created by Ali Alobaidi on 10/5/19.
//  Copyright © 2019 Ali Alobaidi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var email: String!
    var password: String!

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        getUserInput()
        
        if email.count > 0 && password.count > 0 {
            let user = User(email: email, password: password)
            user.login(completion: goToNextScreen)
        }
    }
    
    func getUserInput() {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            self.email = email
            self.password = password
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LoginViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func goToNextScreen(error: Error?, user: AuthDataResult?) {
        if error != nil {
            alert(message: error!.localizedDescription, title: "Oops something wen't wrong")
        } else if user != nil {
            let users = Users()
            users.findUserType(withId: user!.user.uid, completion: goToClientOrAdmin)
        }
    }
    
    func goToClientOrAdmin(type: UserType) {
        if type == .admin {
            performSegue(withIdentifier: "goToAdminScreen", sender: nil)
        } else if type == .client {
            performSegue(withIdentifier: "goToHomeScreen", sender: nil)
        }
    }
    
}
