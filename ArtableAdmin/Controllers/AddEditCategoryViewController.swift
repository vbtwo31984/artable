//
//  AddEditCategoryViewController.swift
//  ArtableAdmin
//
//  Created by V.Burmistrovich on 07/30/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class AddEditCategoryViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var categoryImage: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addEditButton: RoundedButton!
    
    var categoryToEdit: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(chooseImage(_:)))
        tap.numberOfTapsRequired = 1
        categoryImage.addGestureRecognizer(tap)
        
        if let category = categoryToEdit {
            title = "Edit Category"
            nameText.text = category.name
            if let url = URL(string: category.imageUrl) {
                categoryImage.contentMode = .scaleAspectFill
                categoryImage.kf.setImage(with: url)
                addEditButton.setTitle("Save Changes", for: .normal)
            }
        }
        else {
            title = "New Category"
        }
    }
    
    @objc func chooseImage(_ tap: UITapGestureRecognizer) {
        launchImagePicker()
    }

    @IBAction func addCategoryPressed(_ sender: Any) {
        uploadImage()
    }
    
    fileprivate func handleError(_ error: Error) {
        self.simpleAlert(title: "Error", message: error.localizedDescription)
        debugPrint(error)
        self.activityIndicator.stopAnimating()
    }
    
    func uploadImage() {
        guard let image = categoryImage.image,
            let categoryName = nameText.text, categoryName.isNotEmpty else {
                simpleAlert(title: "Error", message: "Must add category image and name")
                return
        }
        
        if let imageData = image.jpegData(compressionQuality: 0.2) {
            activityIndicator.startAnimating()
            let imageRef = Storage.storage().reference().child("/categoryImages/\(categoryName).jpg")
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
        var category = Category(name: nameText.text!, id: "", imageUrl: url)
        
        if let editCategory = categoryToEdit {
            docRef = Firestore.firestore().collection("categories").document(editCategory.id)
            category.id = editCategory.id
        }
        else {
            docRef = Firestore.firestore().collection("categories").document()
            category.id = docRef.documentID
        }
        
        docRef.setData(category.data, merge: true) { (error) in
            if let error = error {
                self.handleError(error)
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension AddEditCategoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func launchImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            categoryImage.contentMode = .scaleAspectFill
            categoryImage.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
