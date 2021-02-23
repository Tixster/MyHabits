//
//  TabBarController.swift
//  MyHabits
//
//  Created by Кирилл Тила on 19.02.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()

    }
    
    private func setupTabBar(){
        self.view.backgroundColor = .white

        let habitsViewController = UINavigationController(rootViewController: HabitsViewController())
        let infoViewController = UINavigationController(rootViewController: InfoViewController())
        var subviewControllers: [UIViewController] = []
        
        
        subviewControllers.append(habitsViewController)
        subviewControllers.append(infoViewController)

        habitsViewController.tabBarItem = UITabBarItem(title: "Привычки", image: #imageLiteral(resourceName: "habits_tab_icon"), selectedImage: #imageLiteral(resourceName: "habits_tab_icon"))
        habitsViewController.tabBarItem.tag = 0
        infoViewController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))
        infoViewController.tabBarItem.tag = 1

        self.setViewControllers(subviewControllers, animated: true)
        self.selectedIndex = 0
        self.tabBar.tintColor = UIColor(named: "Purple")
        self.selectedViewController = habitsViewController
    }
    
}
