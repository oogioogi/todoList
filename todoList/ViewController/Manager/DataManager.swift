//
//  DataManager.swift
//  todoList
//
//  Created by 이용석 on 2020/12/20.
//

import Foundation
import CoreData

class DataManager {
    
    static var shared = DataManager()
    
    var toDoList = [CoreData]()
    
    var mainContenxt: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    
    // 데이터 처음 불러옮
    func fetchToDoList() {
        let request: NSFetchRequest<CoreData> = CoreData.fetchRequest()
        let sortByDateDesc = NSSortDescriptor(key: "sortIndex", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            toDoList = try mainContenxt.fetch(request)
        } catch {
            print("\(error.localizedDescription)")
        }
        
    }
    // 데이터 삭제
    func deleteToDoList(_ memo: CoreData?){
        if let memo = memo {
            mainContenxt.delete(memo)
            saveContext()
        }
    }
    
    // 데이터 베이스에 새로운 데이터 추가 저장
    func AddNewMemo(Title title: String, Photo photo: Data) {
        let newData = CoreData(context: mainContenxt)
        newData.title = title
        newData.photo = photo
        toDoList.insert(newData, at: 0)
        saveContext()
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "todoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
