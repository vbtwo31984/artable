//
//  Constants.swift
//  Artable
//
//  Created by V.Burmistrovich on 07/16/2019.
//  Copyright © 2019 Vladimir Burmistrovich. All rights reserved.
//

import Foundation
import UIKit

struct Storyboard {
    static let LoginStoryboard = "LoginStoryboard"
    static let Main = "Main"
}

struct StoryboardId {
    static let LoginVC = "loginVC"
}

struct Image {
    static let GreenCheck = "green_check"
    static let RedCheck = "red_check"
}

struct Color {
    static let Blue = #colorLiteral(red: 0.2274509804, green: 0.2666666667, blue: 0.3607843137, alpha: 1)
    static let Red = #colorLiteral(red: 0.8739202619, green: 0.4776076674, blue: 0.385545969, alpha: 1)
    static let White = #colorLiteral(red: 0.9626371264, green: 0.959995091, blue: 0.9751287103, alpha: 1)
}

struct Identifier {
    static let CategoryCell = "CategoryCell"
    static let ProductCell = "ProductCell"
}

struct Segue {
    static let ToProducts = "toProductsVC"
    static let ToAddEditCategory = "toAddEditCategory"
    static let ToEditCategory = "toEditCategory"
    static let ToAddEditProduct = "toAddEditProduct"
}
