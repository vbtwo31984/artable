//
//  ProductCell.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/22/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImage: RoundedImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(product: Product) {
        title.text = product.name
        price.text = String(product.price)
        if let url = URL(string: product.imageUrl) {
            let placeholder = UIImage(named: "placeholder")
            productImage.kf.indicatorType = .activity
            productImage.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.1))])
        }
    }

    @IBAction func favoritePressed(_ sender: Any) {
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
    }
    
}
