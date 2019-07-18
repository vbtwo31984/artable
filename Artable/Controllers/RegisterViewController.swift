//
//  RegisterViewController.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/16/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordCheckImage: UIImageView!
    @IBOutlet weak var confirmPasswordCheckImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        confirmPasswordText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if passwordText.text == confirmPasswordText.text {
            passwordCheckImage.image = UIImage(named: Image.GreenCheck)
            confirmPasswordCheckImage.image = UIImage(named: Image.GreenCheck)
        }
        else {
            passwordCheckImage.image = UIImage(named: Image.RedCheck)
            confirmPasswordCheckImage.image = UIImage(named: Image.RedCheck)
        }
        if textField == confirmPasswordText {
            passwordCheckImage.isHidden = false
            confirmPasswordCheckImage.isHidden = false
        } else {
            if passwordText.text!.isEmpty {
                confirmPasswordText.text = ""
                passwordCheckImage.isHidden = true
                confirmPasswordCheckImage.isHidden = true
            }
        }
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailText.text, email.isNotEmpty,
            let username = usernameText.text, username.isNotEmpty,
            let password = passwordText.text, password.isNotEmpty
            else { return }
        
        activityIndicator.startAnimating()
        
        guard let user = Auth.auth().currentUser else { return }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        user.link(with: credential) { authResult, error in
            self.activityIndicator.stopAnimating()
            
            if let error = error {
                debugPrint(error)
                self.handleFireAuthError(error: error)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
