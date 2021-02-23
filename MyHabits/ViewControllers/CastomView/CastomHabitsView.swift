//
//  CastomHabitsView.swift
//  MyHabits
//
//  Created by Кирилл Тила on 21.02.2021.
//

import UIKit


protocol  CastomViewFuncDelegate {
    func tapSaveButton()
    func colorPicker()
}

final class CastomHabitsView: UIView, UITextFieldDelegate {
    
    var funcCastomView: CastomViewFuncDelegate?
    let picker = UIColorPickerViewController()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleColor: UILabel!
    @IBOutlet weak var colorVIew: UIView! {

        didSet {
            colorVIew.layer.cornerRadius = 30 / 2
            colorVIew.backgroundColor = .black
        }
    }
    @IBOutlet weak var titleTime: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.datePickerMode = .time
        }
    }
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
       // let newHabit = Habit(name: titleTextField.text!, date: datePicker.date, color: colorVIew.backgroundColor!)
       // let store = HabitsStore.shared
     //   store.habits.append(newHabit)
        print("added ")
        funcCastomView?.tapSaveButton()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        funcCastomView?.tapSaveButton()

    }
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
            saveButton.isEnabled = true
    }
  
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        titleTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func configureView(){
        guard let view = self.loadViewFromNib(nibName: "CastomHabitsSetting") else { return }
        view.frame = self.bounds
        let gesture = UITapGestureRecognizer(target: self, action: #selector(slecetColor))
        colorVIew.addGestureRecognizer(gesture)
        
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)

        self.addSubview(view)
    }
    
    @objc func slecetColor(){
        picker.supportsAlpha = true
        picker.selectedColor = colorVIew.backgroundColor!
        picker.delegate = self
        funcCastomView?.colorPicker()
    }

    @objc func dateChange(){
        getDateFromPicker()
    }
    
    private func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel.text = "Каждый день в " + formatter.string(from: datePicker.date)
        
    }
    
}

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

extension CastomHabitsView: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorVIew.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorVIew.backgroundColor = viewController.selectedColor
    }
 
    
}
