//
//  TaskDetailViewController.swift
//  Task Manager
//
//  Created by Sadman Adib on 29/6/24.
//

import UIKit

class TaskDetailViewController: UIViewController {
    var task: TaskViewModel
    weak var delegate: TaskDetailViewControllerDelegate?

    lazy var nameLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Task Name: "
        v.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return v
    }()

    lazy var taskName: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var detailLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Task Detail: "
        v.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        v.numberOfLines = 0
        v.lineBreakMode = .byWordWrapping
        return v
    }()

    lazy var taskDetail: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.lineBreakMode = .byWordWrapping
        return v
    }()

    lazy var dueOnLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Due On: "
        v.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return v
    }()

    lazy var dueOnDate: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var nameTextField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.placeholder = "Enter task name"
        v.borderStyle = .roundedRect
        v.isHidden = true
        return v
    }()

    lazy var detailTextView: UITextView = {
        let v = UITextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isScrollEnabled = true
        v.font = UIFont.systemFont(ofSize: 16)
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 5
        v.isHidden = true
        return v
    }()

    lazy var dueDatePicker: UIDatePicker = {
        let v = UIDatePicker()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.datePickerMode = .date
        v.minimumDate = Date()
        v.isHidden = true
        return v
    }()

    lazy var editButton: UIButton = {
        let v = UIButton(type: .system)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("Edit", for: .normal)
        v.addTarget(self, action: #selector(editTask), for: .touchUpInside)
        return v
    }()

    lazy var updateButton: UIButton = {
        let v = UIButton(type: .system)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("Update", for: .normal)
        v.addTarget(self, action: #selector(updateTask), for: .touchUpInside)
        return v
    }()

    private var isEditingTask = false

    init(task: TaskViewModel) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureView(with: task)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Task Details"

        [nameLabel, taskName, detailLabel, taskDetail, dueOnLabel, dueOnDate, nameTextField, detailTextView, dueDatePicker, editButton, updateButton].forEach { subView in
            view.addSubview(subView)
        }

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            taskName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            taskName.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            taskName.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            nameTextField.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            detailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            detailLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),

            taskDetail.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 8),
            taskDetail.leadingAnchor.constraint(equalTo: detailLabel.leadingAnchor),
            taskDetail.trailingAnchor.constraint(equalTo: detailLabel.trailingAnchor),

            detailTextView.topAnchor.constraint(equalTo: taskDetail.bottomAnchor, constant: 8),
            detailTextView.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            detailTextView.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            detailTextView.heightAnchor.constraint(equalToConstant: 100),

            dueOnLabel.topAnchor.constraint(equalTo: detailTextView.bottomAnchor, constant: 16),
            dueOnLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            dueOnLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),

            dueOnDate.topAnchor.constraint(equalTo: dueOnLabel.bottomAnchor, constant: 8),
            dueOnDate.leadingAnchor.constraint(equalTo: dueOnLabel.leadingAnchor),
            dueOnDate.trailingAnchor.constraint(equalTo: dueOnLabel.trailingAnchor),

            dueDatePicker.topAnchor.constraint(equalTo: dueOnDate.bottomAnchor, constant: 8),
            dueDatePicker.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            dueDatePicker.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),

            editButton.topAnchor.constraint(equalTo: dueDatePicker.bottomAnchor, constant: 20),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            updateButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func configureView(with task: TaskViewModel) {
        taskName.text = task.name
        taskDetail.text = task.detail
        dueOnDate.text = task.dueOn.formatted(date: .abbreviated, time: .omitted)
        nameTextField.text = task.name
        detailTextView.text = task.detail
        dueDatePicker.date = task.dueOn
    }

    @objc private func editTask() {
        isEditingTask.toggle()
        taskName.isHidden = isEditingTask
        taskDetail.isHidden = isEditingTask
        dueOnDate.isHidden = isEditingTask
        nameTextField.isHidden = !isEditingTask
        detailTextView.isHidden = !isEditingTask
        dueDatePicker.isHidden = !isEditingTask
        editButton.setTitle(isEditingTask ? "Cancel" : "Edit", for: .normal)
    }

    @objc private func updateTask() {
        guard let name = nameTextField.text, !name.isEmpty,
              let detail = detailTextView.text, !detail.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Task name and detail can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        delegate?.didUpdateTask(name: name, detail: detail, dueOn: dueDatePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
