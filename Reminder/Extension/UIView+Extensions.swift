//
//  UIView+Extensions.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import Foundation
import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    static var identifier: String {
        String(describing: self)
    }
}
