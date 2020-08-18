//
//  RealmSwiftHelper.swift
//  FinalProject
//
//  Created by yespinoza on 8/17/20.
//

import Foundation
import RealmSwift

struct RealmSwiftHelper{
    
    static var instance:RealmSwiftHelper?
    
    static func getInstance() -> RealmSwiftHelper{
        if instance == nil{
            instance = RealmSwiftHelper.init()
        }
        return instance!
    }
    
    func add(_ param:Object){
        let realm = try! Realm()
        try! realm.write { realm.add(param) }
    }
    
    func get<T:Object>(_ filter:String?) -> [T]{
        do{
            let realm = try! Realm()
            var results:Results<T> = try! realm.objects(T.self)
            if results.count > 0, let filter = filter, filter != "" {
                let resultPredicate = NSPredicate(format: filter)
                results = results.filter(resultPredicate)
            }
            if results.count > 0 {
                return Array(results)
            }else{
                return []
            }
        }catch{
            return []
        }
    }
    
    func update<T:Object>(_ param:T, filter:String){
        let realm = try! Realm()
        let realmObject = realm.objects(T.self).filter(filter).first
        try! realm.write {
            try! realm.delete(realmObject!)
            try! realm.add(param)
        }
    }
    
    func delete(_ param:Object){
        let realm = try! Realm()
        try! realm.write { realm.delete(param) }
    }
}
