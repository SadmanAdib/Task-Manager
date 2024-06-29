//
//  TaskListViewControllerDataSource.swift
//  Task Manager
//
//  Created by Sadman Adib on 28/6/24.
//

import UIKit

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(by: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? TaskListTableViewCell else {
            return UITableViewCell()
        }

        let task = viewModel.task(by: indexPath.row)
        cell.configure(with: task, indexPath: indexPath, delegate: self)
        return cell
    }
}

extension TaskListViewController: TaskListTableViewCellDelegate {
    func didTapCheckmarkButton(at indexPath: IndexPath) {
        completeTask(at: indexPath)
    }
}
