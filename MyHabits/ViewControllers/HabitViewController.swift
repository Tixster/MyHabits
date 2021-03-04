//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Кирилл Тила on 03.03.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let picker = UIColorPickerViewController()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

     var titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Бегать по утрам, спать по 8 часов и т.п.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)])
        
        titleTextField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleTextField.textColor = UIColor(named: "Blue")
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        return titleTextField
    }()
    
    private let titleColor: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 30 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
  
        return view
    }()
    
    let titleTime: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        label.text = "Каждый день в " + formatter.string(from: datePicker.date )
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle("Удалить привычку", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let saveHabitsButton =  UIBarButtonItem.init(title: "Сохранить", style: .done, target: self, action: #selector(saveHabits))
        let cancelHabitsButton =  UIBarButtonItem.init(title: "Отменить", style: .done, target: self, action: #selector(cancelHabits))
        
        navigationItem.rightBarButtonItem = saveHabitsButton
        saveHabitsButton.tintColor = UIColor(named: "Purple")
        
        navigationItem.leftBarButtonItem = cancelHabitsButton
        cancelHabitsButton.tintColor = UIColor(named: "Purple")

    }
    
    @objc private func selectColor(){
        picker.supportsAlpha = true
        picker.selectedColor = colorView.backgroundColor!
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    @objc private func dateChange(){
        getDateFromPicker()
    }
    
    @objc private func deleteHabit(){
        let allertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("Отмена") }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }
        
        present(allertController, animated: true, completion: nil)
        allertController.addAction(cancelAction)
        allertController.addAction(deleteAction)
        
    }
    
    private func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        timeLabel.text = "Каждый день в " + formatter.string(from: datePicker.date)
    }
    
    @objc private func saveHabits(){
        let newHabit = Habit(name: titleTextField.text!, date: datePicker.date, color: colorView.backgroundColor!)
        let store = HabitsStore.shared
        
        store.habits.insert(newHabit, at: 0)
     
        if let rd = reload {
            rd.reloadCollection()
        }
        self.dismiss(animated: true) 
        
        print("added")
    }
    
    @objc private func cancelHabits(){
        dismiss(animated: true, completion: nil)
    }
    
    private func setupContent(){
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.addSubviews(titleLabel, timeLabel, datePicker, colorView, titleColor, titleTime, titleTextField, deleteButton)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectColor))
        colorView.addGestureRecognizer(gesture)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            titleTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleColor.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            titleColor.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),

            colorView.topAnchor.constraint(equalTo: titleColor.bottomAnchor, constant: 7),
            colorView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            
            titleTime.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 15),
            titleTime.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            timeLabel.topAnchor.constraint(equalTo: titleTime.bottomAnchor, constant: 7),
            timeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            datePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15),
            datePicker.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            deleteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            deleteButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 100),
            deleteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorView.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorView.backgroundColor = viewController.selectedColor
    }
    
}

extension UIView {
    func addSubviews(_ subviews: UIView...){
        subviews.forEach {addSubview($0)}
        
    }
}