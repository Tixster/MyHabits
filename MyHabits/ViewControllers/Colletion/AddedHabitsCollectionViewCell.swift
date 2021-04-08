//
//  AddedHabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Кирилл Тила on 20.02.2021.
//

import UIKit

class AddedHabitsCollectionViewCell: UICollectionViewCell {
    
    var delegateUpdate: UpdateDelegate?
    var haibt: Habit?
    
    var isChecked = false
    
    let checkBox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(named: "Blue")
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countLable: UILabel = {
        let label = UILabel()
        label.text = "Подряд: "
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var date: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        setupContetn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellHabit(){
        guard let habit = haibt else { return }
        titleLable.text = habit.name
        titleLable.textColor = habit.color
        dateLable.text = habit.dateString
        checkBox.tintColor = habit.color
        countLable.text = "Подряд: "
        date = habit.date
    }
    
    @objc func tapChecked(){
        isChecked.toggle()
        guard let habit = haibt else { return }
        HabitsStore.shared.track(habit)
        self.delegateUpdate?.updateColletion()
    }
    
    private func setupContetn(){
        contentView.addSubview(bgView)
        bgView.addSubview(titleLable)
        bgView.addSubview(dateLable)
        bgView.addSubview(countLable)
        bgView.addSubview(checkBox)
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLable.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 20),
            titleLable.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20),
            
            dateLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 4),
            dateLable.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20),
            
            countLable.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20),
            countLable.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -20),
            
            checkBox.heightAnchor.constraint(equalToConstant: 36),
            checkBox.widthAnchor.constraint(equalToConstant: 36),
            checkBox.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 47),
            checkBox.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -47),
            checkBox.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -26),
        ])
    }
    
}


