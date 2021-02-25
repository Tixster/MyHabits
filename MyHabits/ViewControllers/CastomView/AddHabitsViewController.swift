//
//  AddHabitsViewController.swift
//  MyHabits
//
//  Created by Кирилл Тила on 22.02.2021.
//

import UIKit

class AddHabitsViewController: UIViewController {
    
    private var castViewAdd: CastomHabitsView = {
      let   cast = CastomHabitsView()
       cast.translatesAutoresizingMaskIntoConstraints = false
        return cast
    }()
    
    
    override func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        castViewAdd.navBarTitle.title = "Создать"
        castViewAdd.funcCastomView =  self
        view.backgroundColor = .white
        view.addSubview(castViewAdd)
        
        setupCastView()
    }
    
    private func setupCastView(){
    
        NSLayoutConstraint.activate([
            castViewAdd.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            castViewAdd.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        ])
        castViewAdd.setNeedsLayout()
    }

 
    
    
}

extension AddHabitsViewController: CastomViewFuncDelegate {
    func colorPicker() {
        present(castViewAdd.picker, animated: true, completion: nil)
    }
    
    func tapSaveButton() {
        dismiss(animated: true, completion: nil)
    }
    
}
