//
//  TaskDetailViewControllerDelegate.swift
//  Task Manager
//
//  Created by Sadman Adib on 29/6/24.
//

import Foundation

extension TaskListViewController: TaskDetailViewControllerDelegate {
    func didUpdateTask(name: String?, detail: String?, dueOn: Date?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        let task = viewModel.task(by: selectedIndexPath.row)
        viewModel.updateItem(task: task, name: name, detail: detail, dueOn: dueOn)
        updateView()
    }
}

protocol TaskDetailViewControllerDelegate: AnyObject {
    func didUpdateTask(name: String?, detail: String?, dueOn: Date?)
}
