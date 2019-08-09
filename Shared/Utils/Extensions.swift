//
//  Extensions.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/16/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Firebase

extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension UIViewController {
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension Int {
    func toCurrencyString() -> String {
        let amount = Double(self) / 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }
}
