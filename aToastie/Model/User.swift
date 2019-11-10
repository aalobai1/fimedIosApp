//
//  User.swift
//  aToastie
//
//  Created by Ali Alobaidi on 10/5/19.
//  Copyright © 2019 Ali Alobaidi. All rights reserved.
//

import Foundation
import Firebase

enum UserType: String {
    case admin = "admin"
    case client = "client"
}

class User {
    var email: String
    var password: String
    var uuid: String!
    var type: UserType!
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    convenience init(email: String, uuid: String, type: String) {
        self.init(email: email, password: "")
        self.uuid = uuid
        self.type = UserType(rawValue: type)
    }
    
    
    func signUp(completion: @escaping (_ error: Error?,_ result: AuthDataResult?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            if err != nil {
                completion(err, nil)
            } else {
                completion(nil, user)
                self.uuid = user!.user.uid
                self.createUser(ofType: .client)
            }
        }
    }
    
    func login(completion: @escaping (_ error: Error?,_ result: AuthDataResult?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if err != nil {
                completion(err, nil)
            } else {
                completion(nil, user)
            }
        }
    }
    
    func createUser(ofType type: UserType) {
        let db = Firestore.firestore()
        let collection = db.collection("users")
        
        let userData = [
            "email": self.email,
            "type": type.rawValue,
            "uuid": self.uuid!
        ]
        
        collection.addDocument(data: userData) { (err) in
            if err != nil {
                print("erro")
            }
        }
    }
    
    
}
