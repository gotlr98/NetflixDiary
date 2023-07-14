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
    
    @objc dynamic var id: UUID = UUID()
    let user_net = List<Netflix>()
    
    func set_user(id: UUID){
        
        let user = User()
        user.id = id
        
        let realm = try! Realm()
        
        try! realm.write{
            realm.add(user)
        }
    }
    
    func add_user_net(net: Netflix){
        
    }
}
