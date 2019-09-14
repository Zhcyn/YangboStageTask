//
//  Message.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/15/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

class Message {
    var title: String
    var body: String
    var dateInterval: Date
    
    init(title: String, body: String, dateInterval: Date) {
        self.title = title
        self.body = body
        self.dateInterval = dateInterval
    }
}
