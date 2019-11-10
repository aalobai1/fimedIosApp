//
//  ClientViewController.swift
//  aToastie
//
//  Created by Ali Alobaidi on 10/6/19.
//  Copyright © 2019 Ali Alobaidi. All rights reserved.
//

import UIKit
import Firebase

class AdditionalInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var headerTitleLbl: UILabel!
    @IBOutlet weak var givenNameTxtField: UITextField!
    @IBOutlet weak var familyNameTxtField: UITextField!
    @IBOutlet weak var occupationPicker: UIPickerView!
    @IBOutlet weak var incomeBracketPicker: UIPickerView!
    
    var occupationOptions = Occupation.allCases.map { $0.rawValue }
    var incomeBracketOptions = IncomeBracket.allCases.map { $0.rawValue }
    
    var givenName: String!
    var familyName: String!
    var occupation: Occupation = Occupation.Student
    var incomeBracket: IncomeBracket = IncomeBracket.Poor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        occupationPicker.delegate = self
        occupationPicker.dataSource = self
        incomeBracketPicker.delegate = self
        incomeBracketPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func extractValues() {
        if let givenName = givenNameTxtField.text,
            let familyName = familyNameTxtField.text {
            self.givenName = givenName
            self.familyName = familyName
        }
    }
    
    @IBAction func formSubmitted(_ sender: UIButton) {
        extractValues()
        let patient = Patient(givenName: self.givenName, familyName: self.familyName, occupation: self.occupation, incomeBracket: self.incomeBracket, userId: currentUserId())
        startLoading()
        patient.save { (saved) in
            if saved {
                self.dismiss(animated: false, completion: nil)
                self.performSegue(withIdentifier: "goToMainScreen", sender: nil)
            } else {
                self.alert(message: "Something went wrong")
            }
        }
    }
    
    func currentUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    func startLoading() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1) {
            return occupationOptions.count
        } else {
            return incomeBracketOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if(pickerView.tag == 1) {
            let titleData = occupationOptions[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 15.0)!])
            return myTitle
        } else {
            let titleData = incomeBracketOptions[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 15.0)!])
            return myTitle
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.occupation = Occupation(rawValue: occupationOptions[row])!
        } else {
            self.incomeBracket = IncomeBracket(rawValue: incomeBracketOptions[row])!
        }
    }
}

extension AdditionalInfoViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
