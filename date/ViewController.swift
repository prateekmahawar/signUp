//
//  ViewController.swift
//  date
//
//  Created by Prateek Mahawar on 21/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
// 

import UIKit
let notAllowedCharacters = "/_-=+";

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        if range.length > 0
        {
            return true
        }
        
        //Dont allow empty strings
        if string == " "
        {
            return false
        }
        
        if textField == dobField {

        
        //Check for max length including the spacers we added
        if range.location == 10
        {
            return false
        }
        
        var originalText = textField.text
        let replacementText = string.stringByReplacingOccurrencesOfString("/", withString: "")
        
        //Verify entered text is a numeric value
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        for char in replacementText.unicodeScalars
        {
            if !digits.longCharacterIsMember(char.value)
            {
                return false
            }
        }
        
        if originalText!.characters.count == 2 || originalText!.characters.count == 5
            {
                originalText?.appendContentsOf("/")
                textField.text = originalText
            }
            
        }
        let set = NSCharacterSet(charactersInString: notAllowedCharacters);
        let inverted = set.invertedSet
        
        let filtered = string
            .componentsSeparatedByCharactersInSet(inverted)
            .joinWithSeparator("")
        return filtered != string
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        let nextTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextTag) 
        
        if (nextResponder != nil ) {
            nextResponder?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
        
    @IBAction func submitBtnPressed(sender: AnyObject) {
        let dob = dobField.text

        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        if let dobprop = formatter.dateFromString(dob!) {
            print(dobprop.age)
        } else {
            print("Enter Correct Date")
        }
        
    }
    
    

}

extension NSDate {
    var age: Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: NSDate(), options: []).year
    }
}


func calculateAge (birthday: NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Year, fromDate: birthday, toDate: NSDate(), options: []).year
}

