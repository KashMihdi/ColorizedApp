//
//  Extension + UIView.swift
//  HW 2
//
//  Created by Kasharin Mikhail on 11.04.2023.
//  Copyright © 2023 Alexey Efimov. All rights reserved.
//

import UIKit

extension UIView {
    func setColor(red: Float, green: Float, blue: Float) {
        backgroundColor = UIColor(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: 1
        )
    }
}
