//
//  ViewController.swift
//  Artable
//
//  Created by Vladimir Burmistrovich on 7/14/19.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var loginOutButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var categories = [Category]()
    var selectedCategory: Category!
    var db: Firestore!
    var listener: ListenerRegistration!
    
    fileprivate func signInAnonymously() {
        Auth.auth().signInAnonymously { (result, error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Identifier.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifier.CategoryCell)

        if Auth.auth().currentUser == nil {
            signInAnonymously()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            loginOutButton.title = "Logout"
        }
        else {
            loginOutButton.title = "Login"
        }
        
        //        fetchDocument()
        fetchCollection()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
    }
    
    @IBAction func loginOutPressed(_ sender: Any) {
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            do {
                try Auth.auth().signOut()
                signInAnonymously()
            } catch {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
            }
        }
        presentLoginController()
    }
    
    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        present(controller, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.ToProducts {
            if let destination = segue.destination as? ProductsViewController {
                destination.category = selectedCategory
            }
        }
    }
    
    func fetchCollection() {
        let collectionRef = db.collection("categories")
        
        listener = collectionRef.addSnapshotListener { (snap, error) in
            if let documents = snap?.documents {
                self.categories.removeAll()
                for document in documents {
                    self.categories.append(Category(data: document.data()))
                }
                self.collectionView.reloadData()
            }
        }
        
//        collectionRef.getDocuments { (snap, error) in
//            if let documents = snap?.documents {
//                for document in documents {
//                    self.categories.append(Category(data: document.data()))
//                }
//                self.collectionView.reloadData()
//            }
//        }
    }
    
    func fetchDocument() {
        let docRef = db.collection("categories").document("hFC1lrheE0xeWfERZe4j")
        
        listener = docRef.addSnapshotListener { (snap, error) in
            if let data = snap?.data() {
                self.categories.removeAll()
                let newCategory = Category(data: data)
                self.categories.append(newCategory)
                self.collectionView.reloadData()
            }
        }
        
//        docRef.getDocument { (snap, error) in
//            if let data = snap?.data() {
//                self.categories.append(Category(data: data))
//                self.collectionView.reloadData()
//            }
//        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.CategoryCell, for: indexPath) as? CategoryCell {
            cell.configureCell(category: categories[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 30) / 2
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        performSegue(withIdentifier: Segue.ToProducts, sender: self)
    }
}
