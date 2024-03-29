//
//  ProductsViewController.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/22/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProductsViewController: UIViewController, ProductCellDelegate {
    
    var products = [Product]()
    var category: Category!
    var showFavorites = false
    var db: Firestore!
    var listener: ListenerRegistration!
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifier.ProductCell, bundle: nil), forCellReuseIdentifier: Identifier.ProductCell)
    }
    
    fileprivate func setProductsListener() {
        var ref: Query!
        if(showFavorites) {
            ref = db.collection("users").document(UserService.user.id).collection("favorites")
        }
        else {
            ref = db.products(for: category)
        }
        
        listener = ref.addSnapshotListener({ (snap, error) in
            if let error = error {
                self.simpleAlert(title: "Error", message: error.localizedDescription)
            }
            
            snap?.documentChanges.forEach { change in
                let data = change.document.data()
                let product = Product(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, product: product)
                case .modified:
                    self.onDocumentModified(change: change, product: product)
                case .removed:
                    self.onDocumentRemoved(change: change)
                @unknown default:
                    break
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setProductsListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
        products.removeAll()
        tableView.reloadData()
    }

    func productFavorited(product: Product) {
        if(UserService.isGuest) {
            simpleAlert(title: "Hi friend", message: "This is a user only feature, please create a registered user to take advantange of all our features.")
            return
        }
        UserService.favoriteSelected(product: product)
        if let index = products.firstIndex(of: product) {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
    
    func productAddedToCard(product: Product) {
        if(UserService.isGuest) {
            simpleAlert(title: "Hi friend", message: "This is a user only feature, please create a registered user to take advantange of all our features.")
            return
        }
        StripeCart.addItem(product)
    }
    
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.ProductCell, for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.row], delegate: self)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDetailViewController()
        let selectedProduct = products[indexPath.row]
        vc.product = selectedProduct
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
}

extension ProductsViewController {
    func onDocumentAdded(change: DocumentChange, product: Product) {
        let newIndex = Int(change.newIndex)
        products.insert(product, at: newIndex)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .automatic)
    }
    func onDocumentModified(change: DocumentChange, product: Product) {
        let oldIndex = Int(change.oldIndex)
        let newIndex = Int(change.newIndex)
        
        if(oldIndex == newIndex) {
            products[oldIndex] = product
            tableView.reloadRows(at: [IndexPath(row: oldIndex, section: 0)], with: .automatic)
        }
        else {
            products.remove(at: oldIndex)
            products.insert(product, at: newIndex)
            tableView.performBatchUpdates({
                tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
            }) { worked in
                self.tableView.reloadRows(at: [IndexPath(row: newIndex, section: 0)], with: .automatic)
            }
        }
    }
    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        products.remove(at: oldIndex)
        tableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .automatic)
    }
}
