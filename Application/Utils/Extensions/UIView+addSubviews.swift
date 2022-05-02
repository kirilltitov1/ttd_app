//
//  UIView+addSubviews.swift
//  Application
//
//  Created by Kirill Titov on 04.06.2021.
// https://gist.github.com/individual11/9d11663d0c7f057b6ac4

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}
