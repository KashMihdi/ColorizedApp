//
//  MainViewController.swift
//  HW 2
//
//  Created by Kasharin Mikhail on 11.04.2023.
//  Copyright © 2023 Alexey Efimov. All rights reserved.
//

import UIKit

// MARK: - ColorizedViewControllerDelegate
protocol ColorizedViewControllerDelegate: AnyObject {
    func setValue(for color: Color)
}

class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    private var color = Color(
        redColor: 0.26,
        greenColor: 0.67,
        blueColor: 1.00
    ) {
        didSet {
            view.setColor(
                red: color.redColor,
                green: color.greenColor,
                blue: color.blueColor
            )
        }
    }

    // MARK: - Transfer Data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorizedVC = segue.destination as? ColorizedViewController else { return }
        colorizedVC.color = color
        colorizedVC.delegate = self
    }
}

// MARK: - ColorizedViewControllerDelegate

extension MainViewController: ColorizedViewControllerDelegate {
    func setValue(for color: Color) {
        self.color = color
    }
    
}

