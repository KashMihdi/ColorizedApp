//
//  Extension + Float.swift
//  HW 2
//
//  Created by Kasharin Mikhail on 12.04.2023.
//  Copyright © 2023 Alexey Efimov. All rights reserved.
//

import Foundation

extension Float {
    func string() -> String {
        String(format: "%.2f", self)
    }
}
