//
//  EditViewController.swift
//  MyHabits
//
//  Created by Кирилл Тила on 26.02.2021.
//

import UIKit

class EditViewController: UIViewController {

   private var castViewEdit: CastomHabitsView = {
      let cast = CastomHabitsView()
       cast.translatesAutoresizingMaskIntoConstraints = false
        return cast
    }()
    
    private let scrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private let container: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle("Удалить привычку", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupCastView()
    }
    
    private func setupCastView(){
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(castViewEdit)
        container.addSubview(deleteButton)
        
        castViewEdit.navBarTitle.title = "Править"
        castViewEdit.funcCastomView = self

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            castViewEdit.widthAnchor.constraint(equalTo: container.widthAnchor),
            castViewEdit.topAnchor.constraint(equalTo: container.topAnchor),
            
            deleteButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
            deleteButton.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        
        ])
        
    }

    @objc private func deleteHabit(){
        let allertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }
        
        allertController.addAction(cancelAction)
        allertController.addAction(deleteAction)
        
    }
    

}

extension EditViewController: CastomViewFuncDelegate {
    func tapSaveButton() {
        dismiss(animated: true)
    }
    
    func colorPicker() {
        present(castViewEdit.picker, animated: true, completion: nil)
    }
    
    
}
