//
//  AddEditCategoryViewController.swift
//  ArtableAdmin
//
//  Created by V.Burmistrovich on 07/30/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit

class AddEditCategoryViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var categoryImage: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(chooseImage(_:)))
        tap.numberOfTapsRequired = 1
        categoryImage.addGestureRecognizer(tap)
    }
    
    @objc func chooseImage(_ tap: UITapGestureRecognizer) {
        launchImagePicker()
    }

    @IBAction func addCategoryPressed(_ sender: Any) {
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
