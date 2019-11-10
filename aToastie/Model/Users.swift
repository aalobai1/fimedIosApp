//
//  Users.swift
//  aToastie
//
//  Created by Ali Alobaidi on 10/6/19.
//  Copyright © 2019 Ali Alobaidi. All rights reserved.
//

import Foundation
import Firebase

class Users {
    
    var allUsers: [User] = []
    
    func findUserType(withId uid: String, completion: @escaping (_ type: UserType) -> Void) {
        let db = Firestore.firestore()
        let collection = db.collection("users")
        var userType: UserType = .client
        collection.whereField("uuid", isEqualTo: uid).getDocuments { (snapshot, err) in
            if err != nil {
                print("error")
            } else {
                for document in snapshot!.documents {
                    let type = document.get("type") as! String
                    userType = UserType(rawValue: type)!
                    completion(userType)
                }
            }
        }
    }
    
    func requestUsers(completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        let collection = db.collection("users")
        collection.getDocuments { (snapshot, err) in
            if err != nil {
                
            } else {
                for document in snapshot!.documents {
                    let email = document.get("email") as! String
                    let type = document.get("type") as! String
                    let uuid = document.get("uuid") as! String
                    print(email, type, uuid)
                    let user = User(email: email, uuid: uuid, type: type)
                    self.allUsers.append(user)
                }
                completion()
            }
        }
    }
    
}
