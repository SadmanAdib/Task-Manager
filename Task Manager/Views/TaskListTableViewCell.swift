//
//  TaskListTableViewCell.swift
//  Task Manager
//
//  Created by Sadman Adib on 28/6/24.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {

    weak var delegate: TaskListTableViewCellDelegate?

    var indexPath: IndexPath?

    lazy var taskNameLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        v.numberOfLines = 0
        v.lineBreakMode = .byWordWrapping
        return v
    }()

    lazy var dueOrCompletedLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    }()

    lazy var completedLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    }()

    lazy var checkmarkButton: UIButton = {
        let v = UIButton(type: .system)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(checkmarkButtonTapped), for: .touchUpInside)
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        selectionStyle = . none
        contentView.addSubview(checkmarkButton)
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(dueOrCompletedLabel)
        contentView.addSubview(completedLabel)
        setupConstraint()
    }

    func setupConstraint() {
        NSLayoutConstraint.activate([
            checkmarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskNameLabel.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: 8),
            taskNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            dueOrCompletedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            dueOrCompletedLabel.leadingAnchor.constraint(equalTo: taskNameLabel.leadingAnchor),
            dueOrCompletedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            completedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            completedLabel.trailingAnchor.constraint(equalTo: taskNameLabel.trailingAnchor),
            completedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: taskNameLabel.bottomAnchor, constant: 8)
        ])
    }

    func configure(with task: TaskViewModel, indexPath: IndexPath, delegate: TaskListTableViewCellDelegate) {
        self.indexPath = indexPath
        self.delegate = delegate

        let attributedString = NSMutableAttributedString(string: task.name)
        if task.completed {
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
            taskNameLabel.font = UIFont.italicSystemFont(ofSize: 16)
            checkmarkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            taskNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            checkmarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        taskNameLabel.attributedText = attributedString

        dueOrCompletedLabel.text = task.completed ? "Completed on: \(task.completedOn.formatted(date: .abbreviated, time: .omitted))" : "Due on: \(task.dueOn.formatted(date: .abbreviated, time: .omitted))"

        completedLabel.text = task.completed ? "Completed" : "Not Completed"
        completedLabel.textColor = task.completed ? .green : .red
    }

    @objc
    func checkmarkButtonTapped() {
        if let indexPath = indexPath {
            delegate?.didTapCheckmarkButton(at: indexPath)
        }
    }
}

protocol TaskListTableViewCellDelegate: AnyObject {
    func didTapCheckmarkButton(at indexPath: IndexPath)
}
