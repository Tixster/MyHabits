//
//  AddHabitsViewController.swift
//  MyHabits
//
//  Created by Кирилл Тила on 22.02.2021.
//

import UIKit

final class AddHabitsViewController: UIViewController, CastomViewFuncDelegate {
    
    var castView: CastomHabitsView = {
      let   cast = CastomHabitsView()
       cast.translatesAutoresizingMaskIntoConstraints = false
        return cast
    }()
    
    override func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        castView.navBarTitle.title = "Создать"
        castView.funcCastomView =  self
        view.backgroundColor = .white
        view.addSubview(castView)
        
        setupCastView()
    }
    
    private func setupCastView(){
    
        NSLayoutConstraint.activate([
            castView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            castView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        ])
        castView.setNeedsLayout()
    }

    func colorPicker() {
        present(castView.picker, animated: true, completion: nil)
    }
    
    func tapSaveButton() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
