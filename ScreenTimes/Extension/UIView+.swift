//
//  UIView+.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/8/24.
//

import UIKit

extension UIView: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
