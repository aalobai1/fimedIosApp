//
//  AdminViewController.swift
//  aToastie
//
//  Created by Ali Alobaidi on 10/6/19.
//  Copyright © 2019 Ali Alobaidi. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {
    
    var users: Users = Users()

    override func viewDidLoad() {
        super.viewDidLoad()
        users.requestUsers(completion: updateUI)
    }
    
    func updateUI() {
        
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
