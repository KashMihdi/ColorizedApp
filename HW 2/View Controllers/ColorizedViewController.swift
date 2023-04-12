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
        redTextField.addDoneButton()
        greenTextField.addDoneButton()
        blueTextField.addDoneButton()
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            color.redColor = redSlider.value
        case greenSlider:
            color.greenColor = greenSlider.value
        default:
            color.blueColor = blueSlider.value
        }
        updateUI()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setValue(for: color)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func updateUI() {

        redSlider.value = color.redColor
        greenSlider.value = color.greenColor
        blueSlider.value = color.blueColor
        
        redLabel.text = redSlider.value.string()
        greenLabel.text = greenSlider.value.string()
        blueLabel.text = blueSlider.value.string()
        
        redTextField.text = color.redColor.string()
        greenTextField.text = color.greenColor.string()
        blueTextField.text = color.blueColor.string()
        
        colorView.setColor(
            red: color.redColor,
            green: color.greenColor,
            blue: color.blueColor
        )
    }
}
// MARK: - UITextFieldDelegate
extension ColorizedViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard let digit = Float(text),redSlider.maximumValue > digit else {
            showAlert(
                title: "Wrong number",
                message: "Enter a number between 0 and 1",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redTextField:
            color.redColor = digit
        case greenTextField:
            color.greenColor = digit
        default:
            color.blueColor = digit
        }
        updateUI()
    }
}
// MARK: - Keyboard Call
extension ColorizedViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
// MARK: - Add Done Button for Keyboard
private extension UITextField {
    func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [flexibleSpace, doneButton]
        inputAccessoryView = toolbar
    }

    @objc func doneButtonTapped() {
        resignFirstResponder()
    }
}
// MARK: - UIAlertController
extension ColorizedViewController {
    private func showAlert(title: String, message: String, textField: UITextField?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){ _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
