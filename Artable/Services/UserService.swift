//
//  UserService.swift
//  Artable
//
//  Created by V.Burmistrovich on 08/07/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let UserService = _UserService()

final class _UserService {
    var user = User()
    var favorites = [Product]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListener: ListenerRegistration?
    var favoritesListener: ListenerRegistration?
    
    var isGuest: Bool {
        guard let authUser = auth.currentUser else { return true }
        if authUser.isAnonymous { return true }
        else { return false }
    }
    
    func getCurrentUser() {
        if let authUser = auth.currentUser {
            let userRef = db.collection("users").document(authUser.uid)
            userListener = userRef.addSnapshotListener({ (snap, error) in
                if let error = error {
                    debugPrint(error)
                    return
                }
                
                if let data = snap?.data() {
                    self.user = User(data: data)
                }
            })
            
            let favoritesRef = userRef.collection("favorites")
            favoritesListener = favoritesRef.addSnapshotListener({ (snap, error) in
                if let error = error {
                    debugPrint(error)
                    return
                }
                
                snap?.documents.forEach({ (document) in
                    let favorite = Product(data: document.data())
                    self.favorites.append(favorite)
                })
            })
        }
    }
    
    func logoutUser() {
        userListener?.remove()
        userListener = nil
        favoritesListener?.remove()
        favoritesListener = nil
        
        user = User()
        favorites.removeAll()
    }
}
