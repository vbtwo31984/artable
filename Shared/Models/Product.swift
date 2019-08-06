//
//  Product.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/22/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Product {
    var name: String
    var id: String
    var category: String
    var price: Double
    var productDescription: String
    var imageUrl: String
    var timeStamp: Timestamp
    var stock: Int
    
    init(data: [String: Any]) {
        name = data["name"] as? String ?? ""
        id = data["id"] as? String ?? ""
        category = data["category"] as? String ?? ""
        price = data["price"] as? Double ?? 0
        productDescription = data["description"] as? String ?? ""
        imageUrl = data["imageUrl"] as? String ?? ""
        timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        stock = data["stock"] as? Int ?? 0
    }
    
    init(name: String, id: String, category: String, price: Double, description: String, imageUrl: String, stock: Int, timeStamp: Timestamp = Timestamp()) {
        self.name = name
        self.id = id
        self.category = category
        self.price = price
        self.productDescription = description
        self.imageUrl = imageUrl
        self.stock = stock
        self.timeStamp = timeStamp
    }
    
    var data: [String: Any] {
        return [
            "name": name,
            "id": id,
            "category": category,
            "price": price,
            "description": productDescription,
            "imageUrl": imageUrl,
            "timeStamp": timeStamp,
            "stock": stock
        ]
    }
}
