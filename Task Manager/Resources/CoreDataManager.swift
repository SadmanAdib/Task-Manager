//
//  CoreDataManager.swift
//  Task Manager
//
//  Created by Sadman Adib on 27/6/24.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer (name: "Tasks")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error ((error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error saving the staged changes: \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getAll() -> [Task] {
        var tasks: [Task] = []

        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortByDueDate = NSSortDescriptor(key: "dueOn", ascending: true)
        fetchRequest.sortDescriptors = [sortByDueDate]
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }

        return tasks
    }

    func addNewTask(name: String, detail: String, dueOn: Date) {
        let task = Task(context: context)
        task.name = name
        task.detail = detail
        task.dueOn = dueOn

        task.id = UUID()
        task.completed = false
        task.completedOn = dueOn.advanced(by: 100000)

        saveContext()
    }

    func updateTask(id: UUID, name: String?, detail: String?, dueOn: Date?) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate

        do {
            if let fetchedTask = try context.fetch(fetchRequest).first(where: { $0.id == id }) {
                if let name = name {
                    fetchedTask.name = name
                }
                if let detail = detail {
                    fetchedTask.detail = detail
                }
                if let dueOn = dueOn {
                    fetchedTask.dueOn = dueOn
                }

                saveContext()
                print("updated successfully")
            }
        } catch let error as NSError {
            print("Error updating task: \(error.userInfo), \(error.localizedDescription)")
        }
    }

    func toggleCompleted(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate

        do {
            if let fetchedTask = try context.fetch(fetchRequest).first(where: { $0.id == id }) {
                fetchedTask.completed = !fetchedTask.completed
                if fetchedTask.completed {
                    fetchedTask.completedOn = Date()
                }
            }

            saveContext()
        } catch let error as NSError {
            print("Error toggling state: \(error.userInfo), \(error.localizedDescription)")
        }
    }

    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate

        do {
            let fetchedTasks = try context.fetch(fetchRequest)
            for task in fetchedTasks {
                context.delete(task)
            }

            saveContext()
        } catch {
            print("Error deleting task: \(error.localizedDescription)")
        }
    }
}
