//
//  Task.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/9/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


@objcMembers class Task: Object {
    dynamic var id = UUID().uuidString
    dynamic var taskName: String = ""
    dynamic var isChecked: Bool = false
    dynamic var timer: Date?
    let group = LinkingObjects(fromType: Group.self, property: "tasks")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(taskName: String, timer: Date?) {
        self.init()
        self.taskName = taskName
        self.timer = timer
    }
}
