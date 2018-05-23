//
//  Task+CoreDataProperties.swift
//  coreDataAndFileSystem
//
//  Created by Tianyuan Zhang on 2018/5/22.
//  Copyright © 2018年 Tianyuan Zhang. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var audio: String?
    @NSManaged public var did: String?
    @NSManaged public var id: String?
    @NSManaged public var jobid: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var video: String?
    @NSManaged public var belongs: Job?

}
