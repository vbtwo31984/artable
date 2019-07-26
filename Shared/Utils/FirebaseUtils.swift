//
//  FirebaseUtils.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/19/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import Foundation
import Firebase

extension Firestore {
    var categories: Query {
        return collection("categories").whereField("isActive", isEqualTo: true).order(by: "timeStamp", descending: true)
    }
    func products(for category: Category) -> Query {
        return collection("products").whereField("category", isEqualTo: category.id).order(by: "timeStamp", descending: true)
    }
}

extension Auth {
    func handleFireAuthError(error: Error, vc: UIViewController) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account."
        case .userNotFound:
            return "This user does not exist. Please check the email address used."
        case .userDisabled:
            return "Your account has been disabled."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again later."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password or email is incorrect."
        default:
            return "An error has occured."
        }
    }
}
