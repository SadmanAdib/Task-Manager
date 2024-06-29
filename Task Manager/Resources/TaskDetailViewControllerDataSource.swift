//
//  TaskDetailViewControllerDataSource.swift
//  Task Manager
//
//  Created by Sadman Adib on 29/6/24.
//

import UIKit

extension TaskListViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = viewModel.task(by: indexPath.row)
        let detailVC = TaskDetailViewController(task: task)
        detailVC.delegate = self
        present(detailVC, animated: true, completion: nil)
    }
}
