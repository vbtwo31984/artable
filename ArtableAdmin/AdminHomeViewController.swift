//
//  ViewController.swift
//  ArtableAdmin
//
//  Created by Vladimir Burmistrovich on 7/14/19.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import UIKit

class AdminHomeViewController: HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        let addCategoryButton = UIBarButtonItem(title: "Add Category", style: .plain, target: self, action: #selector(addCategory))
        navigationItem.rightBarButtonItem = addCategoryButton
    }
    
    @objc func addCategory() {
        
    }


}

