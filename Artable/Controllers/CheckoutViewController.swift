//
//  CheckoutViewController.swift
//  Artable
//
//  Created by V.Burmistrovich on 08/09/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Stripe

class CheckoutViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var paymentMethodButton: UIButton!
    @IBOutlet weak var shippingMethodButton: UIButton!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var processingFeeLabel: UILabel!
    @IBOutlet weak var shippingFeeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var paymentContext: STPPaymentContext!
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifier.CardItemCell, bundle: nil), forCellReuseIdentifier: Identifier.CardItemCell)
    }
    
    fileprivate func setupPaymentInfo() {
        subtotalLabel.text = StripeCart.subtotal.toCurrencyString()
        processingFeeLabel.text = StripeCart.processingFee.toCurrencyString()
        shippingFeeLabel.text = StripeCart.shippingFee.toCurrencyString()
        totalLabel.text = StripeCart.total.toCurrencyString()
    }
    
    fileprivate func setupStripeConfig() {
        let config = STPPaymentConfiguration.shared()
        config.createCardSources = true
        config.requiredBillingAddressFields = .none
        config.requiredShippingAddressFields = [.postalAddress]
        
        let customerContext = STPCustomerContext(keyProvider: StripeAPI)
        paymentContext = STPPaymentContext(customerContext: customerContext, configuration: config, theme: .default())
        paymentContext.paymentAmount = StripeCart.total
        paymentContext.delegate = self
        paymentContext.hostViewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupPaymentInfo()
        setupStripeConfig();
    }
    
    @IBAction func placeOrder(_ sender: Any) {
    }
    
    @IBAction func selectPaymentMethod(_ sender: Any) {
        paymentContext.pushPaymentOptionsViewController()
    }
    
    @IBAction func selectShippingMethod(_ sender: Any) {
        paymentContext.pushShippingViewController()
    }

}

extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StripeCart.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.CardItemCell, for: indexPath) as? CardItemCell {
            cell.configureCell(product: StripeCart.cartItems[indexPath.row], at: indexPath.row)
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension CheckoutViewController: CardItemCellDelegate {
    func productRemoved(_ product: Product, at index: Int) {
        StripeCart.removeItem(product)
        tableView.performBatchUpdates({
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        }) { (_) in
            self.tableView.reloadData()
        }
        
        setupPaymentInfo()
        paymentContext.paymentAmount = StripeCart.total
    }
}

extension CheckoutViewController: STPPaymentContextDelegate {
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        
    }
}
