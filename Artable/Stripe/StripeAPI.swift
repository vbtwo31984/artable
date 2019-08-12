//
//  StripeAPI.swift
//  Artable
//
//  Created by V.Burmistrovich on 08/12/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import Foundation
import Stripe
import FirebaseFunctions

let StripeAPI = _StripeAPI()

class _StripeAPI: NSObject, STPCustomerEphemeralKeyProvider {
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let data = [
            "api_version": apiVersion,
            "customer_id": UserService.user.stripeId
        ]
        
        Functions.functions().httpsCallable("getEphemeralStripeKey").call(data) { (result, error) in
            if let error = error {
                debugPrint(error)
                completion(nil, error)
                return
            }
            
            if let key = result?.data as? [String: Any] {
                completion(key, nil)
            }
            else {
                completion(nil, nil)
            }
        }
    }
}
