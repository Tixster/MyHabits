//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Кирилл Тила on 23.02.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {


    let date: HabitsStore

    
    init(date: HabitsStore) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var dateTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HabitsDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: HabitsDetailsTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        let editHabitsButton =  UIBarButtonItem.init(title: "Править", style: .plain, target: self, action: #selector(editHabits))

        navigationItem.rightBarButtonItem = editHabitsButton
        
        navigationController?.navigationBar.tintColor = UIColor(named: "Purple")

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
 
        
    }
    
    @objc private func editHabits(){
         let vc = HabitViewController()

        let navController = UINavigationController(rootViewController: vc)
 //       guard let indexPath = self.dateTableView.indexPathForSelectedRow else {return print("no")}
   //     vc.titleTextField.text = date.habits[indexPath.item].name
     //   vc.colorView.backgroundColor = date.habits[indexPath.item].color
        vc.title = "Править"
        vc.deleteButton.isHidden = false
        self.present(navController, animated: true)
    }
    
    private func setupTableView(){
        view.addSubview(dateTableView)
        
        NSLayoutConstraint.activate([
            dateTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dateTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dateTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
        
    }
}


extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  date.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HabitsDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitsDetailsTableViewCell.self)) as! HabitsDetailsTableViewCell
        
        let index = date.trackDateString(forIndex: indexPath.row)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM, yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        
        cell.textLabel?.text =  index
        
        if date.habit(date.habits[indexPath.row], isTrackedIn: date.habits[indexPath.row].date) == false{
            cell.accessoryType = .none

        } else {
            cell.accessoryType = .checkmark
            cell.tintColor = UIColor(named: "Purple")
        }
        
        return cell
    }
    
    
}
