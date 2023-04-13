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


    @IBOutlet var colorLabels: [UILabel]!
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var colorTextFields: [UITextField]!
    
    
    // MARK: - Public Properties
    var color: Color!
    var setColors: [Float] = []
    unowned var delegate: ColorizedViewControllerDelegate!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        setColors = [color.redColor, color.greenColor, color.blueColor]
        updateUI()
        colorTextFields.forEach{
            $0.delegate = self
            $0.addDoneButton()
        }
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        setColors[sender.tag] = sender.value
        colorLabels[sender.tag].text = sender.value.string()
        colorTextFields[sender.tag].text = sender.value.string()
        setBackgroundView()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setValue(for: color.getColor(for: setColors))
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func setBackgroundView() {
        colorView.setColor(
            red: setColors[0],
            green: setColors[1],
            blue: setColors[2]
        )
    }
    
    private func updateUI() {
        for (index, _) in setColors.enumerated() {
            colorLabels[index].text = setColors[index].string()
            colorSliders[index].value = setColors[index]
            colorTextFields[index].text = setColors[index].string()
        }
        setBackgroundView()
    }
}
// MARK: - UITextFieldDelegate
extension ColorizedViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard let digit = Float(text),colorSliders[0].maximumValue > digit else {
            showAlert(
                title: "Wrong number",
                message: "Enter a number between 0 and 1",
                textField: textField
            )
            return
        }
        
        setColors[textField.tag] = digit
        colorLabels[textField.tag].text = text
        colorSliders[textField.tag].value = digit
        setBackgroundView()
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
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
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
