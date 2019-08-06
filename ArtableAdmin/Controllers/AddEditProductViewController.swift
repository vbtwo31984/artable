//
//  AddEditProductViewController.swift
//  ArtableAdmin
//
//  Created by V.Burmistrovich on 08/02/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class AddEditProductViewController: UIViewController {
    
    var productToEdit: Product?
    var selectedCategory: Category!
    
    @IBOutlet weak var productNameText: UITextField!
    @IBOutlet weak var productPriceText: UITextField!
    @IBOutlet weak var productDescriptionText: UITextView!
    @IBOutlet weak var productImage: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(launchImagePicker))
        tap.numberOfTapsRequired = 1
        productImage.addGestureRecognizer(tap)
        
        if let product = productToEdit {
            title = "Edit Product"
            productNameText.text = product.name
            productDescriptionText.text = product.productDescription
            
            if let url = URL(string: product.imageUrl) {
                productImage.contentMode = .scaleAspectFill
                productImage.kf.setImage(with: url)
            }
            
            productPriceText.text = String(product.price)
            saveButton.setTitle("Save Changes", for: .normal)
        }
        else {
            title = "New Product"
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let name = productNameText.text, name.isNotEmpty,
            let priceString = productPriceText.text,
            let _ = Double(priceString),
            let description = productDescriptionText.text, description.isNotEmpty,
            let image = productImage.image
            else {
                simpleAlert(title: "Error", message: "Must add product name, price, description, and image")
                return
        }
        
        if let imageData = image.jpegData(compressionQuality: 0.2) {
            activityIndicator.startAnimating()
            
            let imageRef = Storage.storage().reference().child("/productImages/\(name).jpg")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    self.handleError(error)
                    return
                }
                
                imageRef.downloadURL(completion: { (url, error) in
                    if let error = error {
                        self.handleError(error)
                        return
                    }
                    
                    if let url = url {
                        self.uploadDocument(url: url.absoluteString)
                    }
                })
            }
        }
    }
    
    func uploadDocument(url: String) {
        var docRef: DocumentReference!
        var product = Product(name: productNameText.text!, id: "", category: selectedCategory.id, price: Double(productPriceText.text!)!, description: productDescriptionText.text!, imageUrl: url, stock: 1)
        
        if let editProduct = productToEdit {
            docRef = Firestore.firestore().collection("products").document(editProduct.id)
            product.id = editProduct.id
        }
        else {
            docRef = Firestore.firestore().collection("products").document()
            product.id = docRef.documentID
        }
        
        docRef.setData(product.data, merge: true) { (error) in
            if let error = error {
                self.handleError(error)
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func handleError(_ error: Error) {
        self.simpleAlert(title: "Error", message: error.localizedDescription)
        debugPrint(error)
        activityIndicator.stopAnimating()
    }
    
}

extension AddEditProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func launchImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            productImage.contentMode = .scaleAspectFill
            productImage.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
