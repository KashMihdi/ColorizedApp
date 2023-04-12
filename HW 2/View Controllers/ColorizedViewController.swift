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
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    // MARK: - Public Properties
    var color: Color!
    unowned var delegate: ColorizedViewControllerDelegate!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        updateUI()
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            color.redColor = redSlider.value
            updateUI()
        case greenSlider:
            color.greenColor = greenSlider.value
            updateUI()
        default:
            color.blueColor = blueSlider.value
            updateUI()
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
        print(color.redColor)
        print(color.greenColor)
        print(color.blueColor)

        redSlider.value = color.redColor
        greenSlider.value = color.greenColor
        blueSlider.value = color.blueColor
        
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
        
        redTextField.text = String(format: "%.2f", color.redColor)
        greenTextField.text = String(format: "%.2f", color.greenColor)
        blueTextField.text = String(format: "%.2f", color.blueColor)
        
        colorView.setColor(
            red: color.redColor,
            green: color.greenColor,
            blue: color.blueColor
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension ColorizedViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField {
        case redTextField:
            color.redColor = Float(text) ?? 0
        case greenTextField:
            color.greenColor = Float(text) ?? 0
        default:
            color.blueColor = Float(text) ?? 0
        }
        updateUI()
    }
}
