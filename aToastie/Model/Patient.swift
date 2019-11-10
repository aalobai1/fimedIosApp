//
//  Patient.swift
//  aToastie
//
//  Created by Ali Alobaidi on 11/10/19.
//  Copyright © 2019 Ali Alobaidi. All rights reserved.
//

import Foundation
import Firebase

enum Occupation: String, CaseIterable {
    case Student
    case PartTimeEmployee = "Part Time Employee"
    case FullTimeEmployaa = "Full Time Employee"
    case Retired
}

enum IncomeBracket: String, CaseIterable {
    case Rich
    case Poor
}

class Patient {
    var givenName: String
    var familyName: String
    var occupation: Occupation.RawValue
    var incomeBracket: IncomeBracket.RawValue
    var userId: String
    
    var asDictionary : [String:Any] {
      let mirror = Mirror(reflecting: self)
      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
        guard label != nil else { return nil }
        return (label!,value)
      }).compactMap{ $0 })
      return dict
    }
    
    init(givenName: String, familyName: String, occupation: Occupation, incomeBracket: IncomeBracket, userId: String) {
        self.givenName = givenName
        self.familyName = familyName
        self.occupation = occupation.rawValue
        self.incomeBracket = incomeBracket.rawValue
        self.userId = userId
    }
    
    func save(completion: @escaping (_ saved: Bool) -> Void) {
        let db = Firestore.firestore()
        let collection = db.collection("patients")
        
        let patientData = self.asDictionary
        print(patientData)
        collection.addDocument(data: patientData) { (err) in
            if err != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
}
