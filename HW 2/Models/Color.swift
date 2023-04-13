//
//  Color.swift
//  HW 2
//
//  Created by Kasharin Mikhail on 11.04.2023.
//  Copyright © 2023 Alexey Efimov. All rights reserved.
//

import Foundation

struct Color {
    var redColor: Float
    var greenColor: Float
    var blueColor: Float
    
    func getColor(for set: [Float]) -> Color {
        Color(redColor: set[0], greenColor: set[1], blueColor: set[2])
    }
}
