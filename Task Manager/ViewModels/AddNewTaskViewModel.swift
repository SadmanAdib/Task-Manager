//
//  AddNewTaskViewModel.swift
//  Task Manager
//
//  Created by Sadman Adib on 27/6/24.
//

import Foundation

class AddNewTaskViewModel {
    func addTask(name: String, detail: String, dueOn: Date) {
        CoreDataManager.shared.addNewTask(name: name, detail: detail, dueOn: dueOn)
    }
}
