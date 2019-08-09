//
//  ProductCell.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/22/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Kingfisher

protocol ProductCellDelegate : class {
    func productFavorited(product: Product)
    func productAddedToCard(product: Product)
}

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImage: RoundedImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: ProductCellDelegate?
    private var product: Product!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(product: Product, delegate: ProductCellDelegate) {
        self.product = product
        self.delegate = delegate
        
        title.text = product.name
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        price.text = formatter.string(from: NSNumber(value: product.price))
        if let url = URL(string: product.imageUrl) {
            let placeholder = UIImage(named: Image.Placeholder)
            productImage.kf.indicatorType = .activity
            productImage.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.1))])
        }
        
        if UserService.favorites.contains(product) {
            favoriteButton.setImage(UIImage(named: Image.FilledStar), for: .normal)
        }
        else {
            favoriteButton.setImage(UIImage(named: Image.EmptyStar), for: .normal)
        }
    }

    @IBAction func favoritePressed(_ sender: Any) {
        delegate?.productFavorited(product: product)
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
        delegate?.productAddedToCard(product: product)
    }
    
}
