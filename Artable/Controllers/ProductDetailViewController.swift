//
//  ProductDetailViewController.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/29/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var bgView: UIVisualEffectView!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productTitle.text = product.name
        productDescription.text = product.productDescription
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: NSNumber(value: product.price)) {
            self.price.text = price
        }
        
        if let url = URL(string: product.imageUrl) {
            productImage.kf.setImage(with: url)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissProduct(_:)))
        tap.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func dismissProduct() {
        dismissProduct(self)
    }
    
    @IBAction func addCardPressed(_ sender: Any) {
        StripeCart.addItem(product)
        dismissProduct()
    }
    
    @IBAction func dismissProduct(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
