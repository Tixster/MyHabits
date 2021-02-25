//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Кирилл Тила on 19.02.2021.
//

import UIKit


class HabitsViewController: UIViewController {
    

    
    private let habitsColletion = HabitsCollectionView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let addHabitsButton =  UIBarButtonItem.init(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addHabits))

        title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addHabitsButton
        addHabitsButton.tintColor = UIColor(named: "Purple")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationItem.rightBarButtonItem = nil

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitsColletion.navDelegate = self
        setupCV()
        view.backgroundColor = .white
    }
    
    private func setupCV(){
        view.addSubview(habitsColletion)
        
        NSLayoutConstraint.activate([
            habitsColletion.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsColletion.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            habitsColletion.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitsColletion.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
    }
    
    @objc private func addHabits(){
        let vc = AddHabitsViewController()
       // let navC = UINavigationController(rootViewController: vc)
        //self.present(navC, animated: true, completion: nil)
        navigationController?.present(vc, animated: true, completion: nil)
    }
    


}


extension HabitsViewController: NavDelagate {
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
