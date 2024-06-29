//
//  TaskViewModel.swift
//  Task Manager
//
//  Created by Sadman Adib on 27/6/24.
//

import Foundation

struct TaskViewModel {
    private var task: Task

    init(task: Task) {
        self.task = task
    }

    var id: UUID {
        task.id ?? UUID()
    }

    var name: String {
        task.name ?? ""
    }

    var detail: String {
        task.detail ?? ""
    }

    var dueOn: Date {
        task.dueOn ?? .now
    }

    var completedOn: Date {
        task.completedOn ?? .now
    }

    var completed: Bool {
        task.completed
    }
}
