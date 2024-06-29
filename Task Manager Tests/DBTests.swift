//
//  DBTests.swift
//  Task Manager Tests
//
//  Created by Sadman Adib on 29/6/24.
//

import XCTest
import CoreData
@testable import Task_Manager

class BDTests: XCTestCase {
    var coreDataManager: CoreDataManager!

    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager.shared

        let container = NSPersistentContainer(name: "Tasks")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { (description, error) in
            XCTAssertNil(error)
        }
        coreDataManager.persistentContainer = container
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
    }

    func testAddNewTask() {
        let taskName = "Test Task"
        let taskDetail = "Test Detail"
        let dueDate = Date()

        coreDataManager.addNewTask(name: taskName, detail: taskDetail, dueOn: dueDate)
        let tasks = coreDataManager.getAll()

        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks.first?.name, taskName)
        XCTAssertEqual(tasks.first?.detail, taskDetail)
        XCTAssertEqual(tasks.first?.dueOn, dueDate)
    }

    func testUpdateTask() {
        let taskName = "Test Task"
        let taskDetail = "Test Detail"
        let dueDate = Date()
        coreDataManager.addNewTask(name: taskName, detail: taskDetail, dueOn: dueDate)

        var tasks = coreDataManager.getAll()
        guard let task = tasks.first else {
            XCTFail("Task not found")
            return
        }

        let updatedName = "Updated Task"
        let updatedDetail = "Updated Detail"
        let updatedDueDate = dueDate.addingTimeInterval(3600) // 1 hour later
        coreDataManager.updateTask(id: task.id!, name: updatedName, detail: updatedDetail, dueOn: updatedDueDate)

        tasks = coreDataManager.getAll()
        guard let updatedTask = tasks.first else {
            XCTFail("Task not found after update")
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(updatedTask.name, updatedName)
            XCTAssertEqual(updatedTask.detail, updatedDetail)
            XCTAssertEqual(updatedTask.dueOn, updatedDueDate)
        }
    }

    func testToggleCompleted() {
        let taskName = "Test Task"
        let taskDetail = "Test Detail"
        let dueDate = Date()
        coreDataManager.addNewTask(name: taskName, detail: taskDetail, dueOn: dueDate)

        if let task = coreDataManager.getAll().first {
            coreDataManager.toggleCompleted(id: task.id!)
        }

        let tasks = coreDataManager.getAll()


        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(tasks.count, 1)
            XCTAssertTrue(tasks.first!.completed)
        }
    }

    func testDeleteTask() {
        let taskName = "Test Task"
        let taskDetail = "Test Detail"
        let dueDate = Date()
        coreDataManager.addNewTask(name: taskName, detail: taskDetail, dueOn: dueDate)

        if let task = coreDataManager.getAll().first {
            coreDataManager.delete(id: task.id!)
        }

        let tasks = self.coreDataManager.getAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(tasks.count, 0)
        }
    }

    func testGetAllTasks() {
        let taskName1 = "Task 1"
        let taskDetail1 = "Detail 1"
        let dueDate1 = Date()
        coreDataManager.addNewTask(name: taskName1, detail: taskDetail1, dueOn: dueDate1)

        let taskName2 = "Task 2"
        let taskDetail2 = "Detail 2"
        let dueDate2 = Date().addingTimeInterval(3600)
        coreDataManager.addNewTask(name: taskName2, detail: taskDetail2, dueOn: dueDate2)

        let tasks = coreDataManager.getAll()
        XCTAssertEqual(tasks.count, 2)
        XCTAssertEqual(tasks[0].name, taskName1)
        XCTAssertEqual(tasks[1].name, taskName2)
    }
}

