//
//  RealmConfigure.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/12/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

final class RealmConfigure {
    // MARK: - Properties
    static let currentSchemaVersion: UInt64 = 1
    
    static func configureMigration() {
        //Step 1: Create realm configure
//        let config = Realm.Configuration(fileURL: FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.sharingForReminderExtension")!.appendingPathComponent("db.realm"))
        let config = Realm.Configuration(schemaVersion: currentSchemaVersion, migrationBlock: nil)
        Realm.Configuration.defaultConfiguration = config
        
        do {
            RealmService.shared.realmDB = try Realm(configuration: config)
        } catch let error as NSError {
            print("Error opening realm: \(error)")
        }
    }
}
