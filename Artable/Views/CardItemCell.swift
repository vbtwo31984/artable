//
//  CardItemCell.swift
//  Artable
//
//  Created by V.Burmistrovich on 08/09/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit

protocol CardItemCellDelegate {
    func productRemoved(_ product: Product, at index: Int)
}

class CardItemCell: UITableViewCell {

    @IBOutlet weak var productImage: RoundedImageView!
    @IBOutlet weak var productTitlePriceLabel: UILabel!
    var product: Product!
    var delegate: CardItemCellDelegate?
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeItem(_ sender: Any) {
        delegate?.productRemoved(product, at: index)
    }
    
    func configureCell(product: Product, at index: Int) {
        self.product = product
        self.index = index
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let price = formatter.string(from: NSNumber(value: product.price)) {
            productTitlePriceLabel.text = "\(product.name) \(price)"
        }
        
        if let url = URL(string: product.imageUrl) {
            productImage.kf.setImage(with: url)
        }
    }
    
}
