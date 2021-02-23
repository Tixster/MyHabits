//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Кирилл Тила on 19.02.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let labelTitle: UILabel = {
        let labelName = UILabel()
        labelName.text = "Привычка за 21 день"
        labelName.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        labelName.textColor = .black
        labelName.translatesAutoresizingMaskIntoConstraints = false
        return labelName
    }()
    
    private let labelDis: UILabel = {
        let labelDis = UILabel()
        labelDis.text = """
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

 1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

 2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

 6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

Источник: psychbook.ru
"""
        labelDis.font = UIFont.systemFont(ofSize: 17)
        labelDis.textColor = .black
        labelDis.numberOfLines = 0 
        labelDis.translatesAutoresizingMaskIntoConstraints = false
        return labelDis
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Информация"
        stupContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
            
    }
 
    private func stupContent(){
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(labelTitle)
        container.addSubview(labelDis)
        
        let constraints = [
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

            labelTitle.topAnchor.constraint(equalTo: container.topAnchor, constant: 22),
            labelTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),

            labelDis.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 16),
            labelDis.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            labelDis.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            labelDis.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
}

