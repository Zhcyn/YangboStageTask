//
//  List+.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/12/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


extension List {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
