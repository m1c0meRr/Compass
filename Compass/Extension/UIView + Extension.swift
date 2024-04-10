//
//  UIView + Extension.swift
//  Compass
//
//  Created by Sergey Savinkov on 09.04.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView?]) {
        views.forEach {
            guard let subview = $0 else { return }
            addSubview(subview)
        }
    }
    
    func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }
}
