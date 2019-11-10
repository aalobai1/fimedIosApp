//
//  ViewController.swift
//  aToastie
//
//  Created by Ali Alobaidi on 10/5/19.
//  Copyright © 2019 Ali Alobaidi. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        try! Auth.auth().signOut()
        // Do any additional setup after loading the view.
    }
    
    
    func checkUserSignIn() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                print("user already signed in")
            } else {
                print("new user")
            }
        }
    }
}

