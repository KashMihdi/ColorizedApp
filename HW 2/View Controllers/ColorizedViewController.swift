//
//  ColorizedViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

final class ColorizedViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!

    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    // MARK: - Public Properties
    var color: Color!
    unowned var delegate: ColorizedViewControllerDelegate!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            color.redColor = redSlider.value
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            color.greenColor = greenSlider.value
        default:
            blueLabel.text = string(from: blueSlider)
            color.blueColor = blueSlider.value
        }
        
        colorView.setColor(
            red: redSlider.value,
            green: greenSlider.value,
            blue: blueSlider.value
        )
        
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setValue(for: color)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func updateUI() {
        colorView.layer.cornerRadius = 15
        
        colorView.setColor(
            red: color.redColor,
            green: color.greenColor,
            blue: color.blueColor
        )
        
        redSlider.value = color.redColor
        greenSlider.value = color.greenColor
        blueSlider.value = color.blueColor
        
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
    
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}
