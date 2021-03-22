//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Кирилл Тила on 19.02.2021.
//

import UIKit

class HabitsViewController: UIViewController {

    private let myHabits: HabitsStore = .shared
    
     lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collect = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collect.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        collect.register(AddedHabitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AddedHabitsCollectionViewCell.self))
        collect.delegate = self
        collect.dataSource = self
        collect.backgroundColor = UIColor(named: "WhiteSet")
        collect.showsVerticalScrollIndicator = false
        
        collect.translatesAutoresizingMaskIntoConstraints = false
        return collect
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let addHabitsButton =  UIBarButtonItem.init(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addHabits))

        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addHabitsButton
        addHabitsButton.tintColor = UIColor(named: "Purple")
        
        collectionView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationItem.rightBarButtonItem = nil

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        setupCV()
        view.backgroundColor = .white
    }
    
    private func setupCV(){
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
    }
    
    @objc private func addHabits(){
        let vc = HabitViewController(cell: nil)
        guard let controller = vc else {  return }
        controller.addHabit = self
        let nav = UINavigationController(rootViewController: controller)
        self.present(nav, animated: true, completion: nil)
        controller.title = "Создать"
 
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width - 16 * 2, height: 60)
        default:
            return CGSize(width: collectionView.frame.width - 16 * 2, height: 130)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 22, left: 0, bottom: 18, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return myHabits.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        switch indexPath.section {
        case 0:
            let cell: ProgressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
        
            return cell
        default:
            let cell: AddedHabitsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AddedHabitsCollectionViewCell.self), for: indexPath) as! AddedHabitsCollectionViewCell
            let habit = myHabits.habits[indexPath.item]
            
            cell.setupCellHabit(habits: myHabits, index: indexPath)
            cell.checkBox.addTarget(cell, action: #selector(cell.tapChecked), for: .touchUpInside)
            cell.delegateUpdate = self
            
            if cell.isChecked == true  {
                HabitsStore.shared.track(habit)
            }
            if habit.isAlreadyTakenToday {
                cell.checkBox.isEnabled = false
            } else {
                cell.isChecked = false
                cell.checkBox.isEnabled = true
            }

            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        default:
            let cell = collectionView.cellForItem(at: indexPath) as! AddedHabitsCollectionViewCell
            cell.tag = indexPath.item
            let vc = HabitDetailsViewController(date: myHabits, cell: cell)
            navigationController?.pushViewController(vc, animated: true)

            let habitVc = HabitViewController(cell: cell)
            habitVc?.updateHabit = self
        }
    }

}

extension HabitsViewController: AddDelegate, UpdateDelegate {
    func updateColletion() {
        self.collectionView.reloadData()
        print("update")
    }
    
    
    func addHabit() {
        self.collectionView.reloadData()
        
        print("added")
    }
    
}
