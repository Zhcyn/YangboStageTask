//
//  RealmService.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/12/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class RealmService {
    static let shared = RealmService()
    var realmDB: Realm?
    
    //MARK: Init
    private init() {}
}

extension RealmService {
    func fetch<T: Object>(_ objectType: T.Type) -> Results<T>? {
        let results = realmDB?.objects(objectType)
        return results
    }
    
    func create<T: Object>(_ object: T) {
        do {
            try realmDB?.write {
                realmDB?.add(object)
            }
        } catch let error {
            print(error)
            post(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any]) {
        do {
            try realmDB?.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realmDB?.write {
                realmDB?.delete(object)
            }
        } catch {
            post(error)
        }
    }
    
    fileprivate func post(_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    func observeRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"), object: nil, queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingErrors(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
}
