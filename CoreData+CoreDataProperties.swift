//
//  CoreData+CoreDataProperties.swift
//  todoList
//
//  Created by 이용석 on 2020/12/20.
//
//

import Foundation
import CoreData


extension CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreData> {
        return NSFetchRequest<CoreData>(entityName: "CoreData")
    }

    @NSManaged public var count: Int16
    @NSManaged public var sortIndex: Date?
    @NSManaged public var title: String?
    @NSManaged public var photo: Data?

}

extension CoreData : Identifiable {

}
