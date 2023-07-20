//
//  User.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/04.
//

import Foundation
import UIKit
import RealmSwift

class User: Object{
    
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    let user_net = List<Netflix>()
    
    override static func primaryKey() -> String? {
      return "_id"
    }
    
    func set_user(){
        
        let user = User()
        
        let realm = try! Realm()
        
        try! realm.write{
            realm.add(user)
        }
    }

    func add_user_net(net: Netflix){
        
        let realm = try! Realm()
        
        let user = realm.objects(User.self)
    
        for i in user{
            try! realm.write{
                i.user_net.append(net)
            }
        }
        
    }
    
    func get_user() -> Results<User>{
        
        let realm = try! Realm()
        
        return realm.objects(User.self)
    }
    
    func get_user_count() -> Int {
        
        let realm = try! Realm()
        
        return realm.objects(User.self).count
    }
    
    func delete_all(){
        
        let realm = try! Realm()
        
        try! realm.write{
            realm.deleteAll()
        }
    }
    
//    func get_user_id() -> AnyObject{
//
//        let realm = try! Realm()
//
//        for i in realm.objects(User.self){
//            let id = i._id
//        }
//
//        return id
//    }
    
//    func get_user_net(user: User) -> Results<User>{
//
//        let realm = try! Realm()
//
//        return realm.objects(User.self).filter("id == '\(user.id)'")
//    }
//
//    func delete_net(user: User, net: Netflix){
//
//        let realm = try! Realm()
//
//        let delete = realm.objects(User.self).filter("id == '\(user.id)' && title == '\(net.title)'")
//
//        try! realm.write{
//            realm.delete(delete)
//        }
//    }
}
