//
//  ViewController.swift
//  Artable
//
//  Created by Vladimir Burmistrovich on 7/14/19.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var loginOutButton: UIBarButtonItem!
    
    
    fileprivate func signInAnonymously() {
        Auth.auth().signInAnonymously { (result, error) in
            if let error = error {
                debugPrint(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser == nil {
            signInAnonymously()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            loginOutButton.title = "Logout"
        }
        else {
            loginOutButton.title = "Login"
        }
    }
    
    @IBAction func loginOutPressed(_ sender: Any) {
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            do {
                try Auth.auth().signOut()
                signInAnonymously()
            } catch {
                debugPrint(error)
            }
        }
        presentLoginController()
    }
    
    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        present(controller, animated: true, completion: nil)
    }
}

