//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Кирилл Тила on 23.02.2021.
//

import UIKit

protocol UpdateTitleDelegate: class {
    func updateTitle(title: String)
}

class HabitDetailsViewController: UIViewController {
    
    let tableViewCell = UITableViewCell()
    let date: HabitsStore = .shared
    var habitCell: Habit?
    
    init(date: HabitsStore) {
        self.date.habits = date.habits
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var dateTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(tableViewCell.classForCoder, forCellReuseIdentifier: String(describing: tableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        let editHabitsButton =  UIBarButtonItem.init(title: "Править", style: .plain, target: self, action: #selector(editHabits))
        
        navigationItem.rightBarButtonItem = editHabitsButton
        
        navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
        print("Open")
        title = habitCell?.name
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    @objc private func editHabits(){
        let vc = HabitViewController(habit: habitCell)
        guard let controller = vc else {return}
        guard let date = habitCell?.date else { return }
        controller.removeHabit = self
        controller.updateTitle = self
        let navController = UINavigationController(rootViewController: controller)
        controller.titleTextField.text = habitCell?.name
        controller.colorView.backgroundColor = habitCell?.color
        controller.datePicker.date = date
        
        controller.title = "Править"
        controller.deleteButton.isHidden = false
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
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: tableViewCell.self), for: indexPath)
        guard let habit = habitCell else { return cell }
        cell.textLabel?.text = date.trackDateString(forIndex: indexPath.row)
        
        if date.habit(habit, isTrackedIn: date.dates[indexPath.row]) == false{
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
            cell.tintColor = UIColor(named: "Purple")
        }
        
        return cell
        
    }
    
}

extension HabitDetailsViewController: DeleteDelegate, UpdateTitleDelegate {
    
    func updateTitle(title: String) {
        self.title = title
    }
    
    func removeHabit() {
        self.navigationController?.popViewController(animated: true)
        print("delete")
    }
}
