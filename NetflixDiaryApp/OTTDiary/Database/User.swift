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

    
    func get_user_net() -> [Netflix]{

        let realm = try! Realm()

        let user = realm.objects(User.self)
        
        var net: [Netflix] = []
        
        for i in user{
            net.append(contentsOf: i.user_net)
        }
        
        return net
    }
    

    func delete_net(title: String){

        let realm = try! Realm()

        let a = realm.objects(User.self)
        var net: [Netflix] = []
        
        for i in a{
            net.append(contentsOf: i.user_net)
        }
        
        for j in net{
            if j.title == title{
                try! realm.write{
                    realm.delete(j)
                }
            }
        }
    }
    
    func update_review(title: String, review: String, change_review: String){
        
        let realm = try! Realm()
        
        let a = realm.objects(User.self)
        
        var net: [Netflix] = []
        
        for i in a{
            net.append(contentsOf: i.user_net)
        }
        
        for j in net{
            if j.title == title && j.review == review{
                try! realm.write{
                    j.review = change_review
                }
                print(change_review)
            }
        }
    }
}
