//
//  UIImaveView+Extensions.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import Foundation
import UIKit

public extension UIImageView {
    @available(iOS 13.0, *)
    convenience init(icon: Icon) {
        let image = UIImage(icon: icon) ?? UIImage(systemName: "circle.slash") ?? UIImage()
        self.init(image: image)
    }
}

public extension UIImage {
    @available(iOS 13.0, *)
    convenience init?(icon: Icon) {
        self.init(systemName: icon.rawValue)
    }
}

public enum Icon: String {
    case crossCaseCircleFill = "cross.case.circle.fill"
    case personCropCircleFill = "person.crop.circle.fill"
    case rectanglePortraitAndArrowRight = "rectangle.portrait.and.arrow.right"
    case chevronRight = "chevron.right"
    case newsPaper = "newspaper"
    case pills = "pills"
    case arrowLeft = "arrow.left"
    case square = "square"
}
