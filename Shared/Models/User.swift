//
//  User.swift
//  Artable
//
//  Created by V.Burmistrovich on 08/06/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var email: String
    var username: String
    var stripeId: String
    
    init(id: String = "", email: String = "", username: String = "", stripeId: String = "") {
        self.id = id
        self.email = email
        self.username = username
        self.stripeId = stripeId
    }
    
    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        email = data["email"] as? String ?? ""
        username = data["username"] as? String ?? ""
        stripeId = data["stripeId"] as? String ?? ""
    }
    
    var data: [String: Any] {
        return [
            "id": id,
            "email": email,
            "username": username,
            "stripeId": stripeId
        ]
    }
}
