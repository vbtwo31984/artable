//
//  CheckoutViewController.swift
//  Artable
//
//  Created by V.Burmistrovich on 08/09/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var paymentMethodButton: UIButton!
    @IBOutlet weak var shippingMethodButton: UIButton!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var processingFeeLabel: UILabel!
    @IBOutlet weak var shippingFeeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func placeOrder(_ sender: Any) {
    }
    
    @IBAction func selectPaymentMethod(_ sender: Any) {
    }
    
    @IBAction func selectShippingMethod(_ sender: Any) {
    }
    
}
