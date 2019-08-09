//
//  CardItemCell.swift
//  Artable
//
//  Created by V.Burmistrovich on 08/09/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit

class CardItemCell: UITableViewCell {

    @IBOutlet weak var productImage: RoundedImageView!
    @IBOutlet weak var productTitlePriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeItem(_ sender: Any) {
    }
    
}
