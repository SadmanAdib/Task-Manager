//
//  AddNewTaskViewController.swift
//  Task Manager
//
//  Created by Sadman Adib on 27/6/24.
//

import UIKit

class AddNewTaskViewController: UIViewController {

    lazy var taskNameLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Task Name"
        return v
    }()

    lazy var taskDetailLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Task Detail"
        return v
    }()

    lazy var taskNameTextField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.placeholder = "Enter task name"
        v.borderStyle = .roundedRect
        return v
    }()

    lazy var taskDetailTextView: UITextView = {
        let v = UITextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isScrollEnabled = true
        v.font = UIFont.systemFont(ofSize: 16)
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 5
        return v
    }()

    lazy var dueOnLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Due On"
        return v
    }()

    lazy var dueOnDatePicker: UIDatePicker = {
        let v = UIDatePicker()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.datePickerMode = .date
        v.minimumDate = Date()
        return v
    }()

    let viewModel = AddNewTaskViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Add New Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))

        [taskNameLabel,
         taskDetailLabel,
         taskNameTextField,
         taskDetailTextView,
         dueOnLabel,
         dueOnDatePicker
        ].forEach { subView in
            view.addSubview(subView)
        }

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            taskNameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 8),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            taskDetailLabel.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 16),
            taskDetailLabel.leadingAnchor.constraint(equalTo: taskNameTextField.leadingAnchor),

            taskDetailTextView.topAnchor.constraint(equalTo: taskDetailLabel.bottomAnchor, constant: 8),
            taskDetailTextView.leadingAnchor.constraint(equalTo: taskNameTextField.leadingAnchor),
            taskDetailTextView.trailingAnchor.constraint(equalTo: taskNameTextField.trailingAnchor),
            taskDetailTextView.heightAnchor.constraint(equalToConstant: 100),

            dueOnLabel.topAnchor.constraint(equalTo: taskDetailTextView.bottomAnchor, constant: 16),
            dueOnLabel.leadingAnchor.constraint(equalTo: taskNameTextField.leadingAnchor),

            dueOnDatePicker.topAnchor.constraint(equalTo: dueOnLabel.bottomAnchor, constant: 8),
            dueOnDatePicker.leadingAnchor.constraint(equalTo: taskNameTextField.leadingAnchor),
            dueOnDatePicker.trailingAnchor.constraint(equalTo: taskNameTextField.trailingAnchor),
        ])
    }

    @objc
    func saveTask() {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty, let taskDetail = taskDetailTextView.text, !taskDetail.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Task name and detail can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let dueOn = dueOnDatePicker.date
        viewModel.addTask(name: taskName, detail: taskDetail, dueOn: dueOn)

        navigationController?.popViewController(animated: true)
    }
}
