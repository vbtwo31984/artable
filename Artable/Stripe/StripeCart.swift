//
//  StripeCart.swift
//  Artable
//
//  Created by V.Burmistrovich on 08/09/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import Foundation

let StripeCart = _StripeCart()

final class _StripeCart {
    var cartItems = [Product]()
    private let stripeCreditCardCut = 0.029
    private let flatFeeCents = 30
    var shippingFee = 0
    
    var subtotal: Int {
        let result = cartItems.reduce(0) { amount, product in
            let pricePennies = Int(product.price * 100)
            return amount + pricePennies
        }
        return result
    }
    var processingFee: Int {
        if subtotal == 0 {
            return 0
        }
        
        let fees = Int(Double(subtotal) * stripeCreditCardCut) + flatFeeCents
        return fees
    }
    var total: Int {
        return subtotal + processingFee + shippingFee
    }
    
    func addItem(_ item: Product) {
        cartItems.append(item)
    }
    func removeItem(_ item: Product) {
        if let index = cartItems.firstIndex(of: item) {
            cartItems.remove(at: index)
        }
    }
    func clear() {
        cartItems.removeAll()
    }
}
