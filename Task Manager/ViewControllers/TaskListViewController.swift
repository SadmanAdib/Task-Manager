//
//  ViewController.swift
//  Task Manager
//
//  Created by Sadman Adib on 27/6/24.
//

import UIKit

class TaskListViewController: UIViewController {

    let viewModel = TaskListViewModel()

    lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dataSource = self
        v.delegate = self
        v.register(TaskListTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        v.estimatedRowHeight = 200
        v.rowHeight = UITableView.automaticDimension
        return v
    }()

    lazy var placeholderLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "No tasks available"
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 20)
        v.textColor = .gray
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )

        view.addSubview(tableView)
        view.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.getAll()
        updateView()
    }

    @objc
    func addNewTask() {
        navigationController?.pushViewController(AddNewTaskViewController(), animated: true)
    }

    func updateView() {
        if viewModel.tasks.isEmpty {
            tableView.isHidden = true
            placeholderLabel.isHidden = false
        } else {
            tableView.isHidden = false
            placeholderLabel.isHidden = true
            tableView.reloadData()
        }
    }
}
