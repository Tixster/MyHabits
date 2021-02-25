//
//  HabitsCollectionView.swift
//  MyHabits
//
//  Created by Кирилл Тила on 20.02.2021.
//

import UIKit

protocol NavDelagate: class {
    func pushVC(_ vc: UIViewController)
}



class HabitsCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    weak var navDelegate: NavDelagate?
    

     init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        register(AddedHabitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AddedHabitsCollectionViewCell.self))
        delegate = self
        dataSource = self
        backgroundColor = UIColor(named: "WhiteSet")
        showsVerticalScrollIndicator = false
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        switch indexPath.section {
        case 0:
            let cell: ProgressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell            
                collectionView.reloadItems(at: [indexPath])

            return cell
        default:
            let cell: AddedHabitsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AddedHabitsCollectionViewCell.self), for: indexPath) as! AddedHabitsCollectionViewCell
            let myHabits = HabitsStore.shared.habits[indexPath.item]
            
            cell.checkBox.addTarget(cell, action: #selector(cell.tapChecked), for: .touchUpInside)
            
            cell.titleLable.text = myHabits.name
            cell.titleLable.textColor = myHabits.color
            cell.dateLable.text = myHabits.dateString
            cell.checkBox.tintColor = myHabits.color
            cell.countLable.text = "Подряд: "
            
            

            if cell.isChecked == true  {
                HabitsStore.shared.track(myHabits)
     
            }
            
            if myHabits.isAlreadyTakenToday {
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
            let myHabits: HabitsStore = .shared
            let vc = HabitDetailsViewController(date: myHabits)
          //  let dates = HabitsStore.shared.dates[indexPath.item]
            navDelegate?.pushVC(vc)
            
            vc.title = HabitsStore.shared.habits[indexPath.item].name
//            vc.dates = dates
            
        }
    }

}
