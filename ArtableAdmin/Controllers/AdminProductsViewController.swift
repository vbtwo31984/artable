//
//  AdminProductsViewController.swift
//  ArtableAdmin
//
//  Created by V.Burmistrovich on 08/02/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit

class AdminProductsViewController: ProductsViewController {
    
    var selectedProduct: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = category.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        selectedProduct = nil
    }
    
    @IBAction func editCategory(_ sender: Any) {
        performSegue(withIdentifier: Segue.ToEditCategory, sender: self)
    }
    
    @IBAction func addProduct(_ sender: Any) {
        performSegue(withIdentifier: Segue.ToAddEditProduct, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: Segue.ToAddEditProduct, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.ToAddEditProduct {
            if let destination = segue.destination as? AddEditProductViewController {
                destination.productToEdit = selectedProduct
                destination.selectedCategory = category
            }
        }
        else if segue.identifier == Segue.ToEditCategory {
            if let destination = segue.destination as? AddEditCategoryViewController {
                destination.categoryToEdit = category
            }
        }
    }
    
}
