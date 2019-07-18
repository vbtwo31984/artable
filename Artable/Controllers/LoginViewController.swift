//
//  LoginViewController.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/16/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let email = emailText.text, email.isNotEmpty,
            let password = passwordText.text, password.isNotEmpty
            else {
                simpleAlert(title: "Error", message: "Please fill out all fields.")
                return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.activityIndicator.stopAnimating()
            
            if let error = error {
                debugPrint(error)
                self.handleFireAuthError(error: error)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func guestPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
