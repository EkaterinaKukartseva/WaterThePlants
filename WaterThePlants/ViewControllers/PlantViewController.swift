//
//  PlantViewController.swift
//  WaterThePlants
//
//  Created by EKATERINA  KUKARTSEVA on 27.01.2021.
//

import UIKit

class PlantViewController: UIViewController {
    
    @IBOutlet weak var lastWateringView: RoundedView!
    @IBOutlet weak var wateringPeriodView: UIView!
    @IBOutlet weak var spryingPeriodView: UIView!
    
    @IBOutlet weak var lastWateringDatePicker: UIDatePicker! {
        didSet {
            lastWateringDatePicker.maximumDate = Date()
        }
    }
    @IBOutlet weak var heightConstraintlastWateringDatePicker: NSLayoutConstraint!
    
    @IBOutlet weak var wateringPeriodPickerView: UIPickerView!
    @IBOutlet weak var heightConstraintWateringPeriodPickerView: NSLayoutConstraint!
    
    @IBOutlet weak var spryingPeriodPickerView: UIPickerView!
    @IBOutlet weak var heightConstraintSpyingPeriodPickerView: NSLayoutConstraint!
    
    @IBOutlet weak var namePlantTextField: UITextField!
    
    private var lastWateringDate = Date()
    private var array: [Int] = Array(1...30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastWateringView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showPicker(_:))))
        lastWateringView.isUserInteractionEnabled = true
        wateringPeriodView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showPicker(_:))))
        wateringPeriodView.isUserInteractionEnabled = true
        spryingPeriodView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showPicker(_:))))
        spryingPeriodView.isUserInteractionEnabled = true
        
        lastWateringDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc func dateChanged() {
        lastWateringDate = lastWateringDatePicker.date
        print(lastWateringDate)
    }
    
    @IBAction func createPlant(_ sender: UIButton) {
        guard let namePlant = namePlantTextField.text, namePlant.count > 0 else { return }
        
        let plant = Plant(context: CoreDataManager.shared.context)
        plant.name = namePlant
        
        CoreDataManager.shared.saveContext()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showPicker(_ sender: UITapGestureRecognizer) {
        
        guard let tag = sender.view?.tag else { return }
        
        switch tag {
        case 1:
            editConstraints(view: lastWateringDatePicker, constraint: heightConstraintlastWateringDatePicker)
        case 2:
            editConstraints(view: wateringPeriodPickerView, constraint: heightConstraintWateringPeriodPickerView)
        case 3:
            editConstraints(view: spryingPeriodPickerView, constraint: heightConstraintSpyingPeriodPickerView)
        default: break
        }
    }
    
    private func editConstraints(view: UIView, constraint:NSLayoutConstraint) {
        constraint.constant = constraint.constant > 0 ? 0 : 190
        view.isHidden = !view.isHidden
        animate()
    }
    
    private func animate() {
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension PlantViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        NSAttributedString(string: "\(array[row])")
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        30
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = (view as? UILabel) ?? UILabel()
        
        pickerLabel.font = UIFont(name: "SourceSansPro-Regular", size: 23)
        pickerLabel.textColor = .white
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.text = "\(array[row])"
        
        return pickerLabel;
    }
    
}
