//
//  CategoryCell.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/22/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.cornerRadius = 5
    }
    
    func configureCell(category: Category) {
        name.text = category.name
        if let url = URL(string: category.imageUrl) {
            image.kf.setImage(with: url)
        }
    }

}
