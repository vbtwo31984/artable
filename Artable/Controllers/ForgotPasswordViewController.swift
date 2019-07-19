//
//  ForgotPasswordViewController.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/18/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        guard let email = emailText.text, email.isNotEmpty else {
            simpleAlert(title: "Error", message: "Please enter email")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
