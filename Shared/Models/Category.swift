//
//  Category.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/19/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imageUrl: String
    var isActive: Bool = true
    var timeStamp: Timestamp
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? false
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
    
    init(name: String, id: String, imageUrl: String, isActive: Bool = true, timeStamp: Timestamp = Timestamp()) {
        self.name = name
        self.id = id
        self.imageUrl = imageUrl
        self.isActive = isActive
        self.timeStamp = timeStamp
    }
    
    var data: [String: Any] {
        let data: [String: Any] = [
            "name": name,
            "id": id,
            "imageUrl": imageUrl,
            "isActive": isActive,
            "timeStamp": timeStamp
        ]
        return data
    }
}
