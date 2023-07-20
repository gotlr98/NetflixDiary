//
//  Netflix.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/04.
//

import Foundation
import RealmSwift
import UIKit

class Netflix: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var img_url: String = ""
    
    func set_net(title: String, url: String){
        
        let net = Netflix()
        
        net.title = title
        net.img_url = url
        
        let realm = try! Realm()
        
        try! realm.write{
            realm.add(net)
        }
    }
}
