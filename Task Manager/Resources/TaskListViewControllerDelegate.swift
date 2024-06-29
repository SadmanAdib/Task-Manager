//
//  TaskListViewControllerDelegate.swift
//  Task Manager
//
//  Created by Sadman Adib on 28/6/24.
//

import UIKit

extension TaskListViewController: UITableViewDelegate {
    func completeTask(at indexPath: IndexPath) {
        let task = viewModel.task(by: indexPath.row)
        viewModel.toggleCompleted(task: task)

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let task = viewModel.task(by: indexPath.row)
        viewModel.deleteItem(task: task)
        tableView.reloadData()
        updateView()
    }
}
