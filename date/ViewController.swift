//
//  ViewController.swift
//  date
//
//  Created by Prateek Mahawar on 21/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let theTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.scrollViewTapped(_:)))
        scrollView.addGestureRecognizer(theTap)
        
    }
    func scrollViewTapped(recognizer: UIGestureRecognizer) {
        scrollView.endEditing(true)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = dobField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        return newLength <= 10
        
        
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == dobField || textField == passwordField || textField==userNameField {
            scrollView.setContentOffset(CGPoint(x: 0,y: 250), animated: true)
            }
        
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
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)

    }
    
    @IBAction func submitBtnPressed(sender: AnyObject) {
        let dob = dobField.text
//        let strTime = "27-07-2015"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dobprop = formatter.dateFromString(dob!)
        print(dobprop!.age)
        
        
    }
    
    

}

extension NSDate {
    var age: Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: NSDate(), options: []).year
    }
}

let myDOB = NSCalendar.currentCalendar().dateWithEra(1, year: 1970, month: 09, day: 10, hour: 0, minute: 0, second: 0, nanosecond: 0)!
let myAge = myDOB.age      // 45


func calculateAge (birthday: NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Year, fromDate: birthday, toDate: NSDate(), options: []).year
}
