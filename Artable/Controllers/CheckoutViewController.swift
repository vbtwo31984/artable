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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupPaymentInfo()

    }
    
    @IBAction func placeOrder(_ sender: Any) {
    }
    
    @IBAction func selectPaymentMethod(_ sender: Any) {
    }
    
    @IBAction func selectShippingMethod(_ sender: Any) {
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
    }
}
