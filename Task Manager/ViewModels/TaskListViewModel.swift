//
//  TaskListViewModel.swift
//  Task Manager
//
//  Created by Sadman Adib on 27/6/24.
//

import Foundation

class TaskListViewModel {
    var tasks: [TaskViewModel] = []

    init() {
        getAll()
    }

    var numberOfTasks: Int {
        tasks.count
    }

    func getAll() {
        tasks = CoreDataManager.shared.getAll().map(TaskViewModel.init)
    }

    func numberOfRows(by section: Int) -> Int {
        return numberOfTasks
    }

    func task(by index: Int) -> TaskViewModel {
        tasks[index]
    }

    func toggleCompleted (task: TaskViewModel) {
        CoreDataManager.shared.toggleCompleted(id: task.id)
        getAll()
    }

    func deleteItem(task: TaskViewModel) {
        CoreDataManager.shared.delete(id: task.id)
        getAll()
    }

    func updateItem(task: TaskViewModel, name: String?, detail: String?, dueOn: Date?) {
        CoreDataManager.shared.updateTask(id: task.id, name: name, detail: detail, dueOn: dueOn)
        getAll()
    }

}
