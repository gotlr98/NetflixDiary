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
    @objc dynamic var review: String = ""
    
    convenience init(title: String, img_url: String, review: String) {
        self.init()
        
        self.title = title
        self.img_url = img_url
        self.review = review
    }
    
    func set_net(title: String, url: String, review: String){
        
        let net = Netflix()
        
        net.title = title
        net.img_url = url
        net.review = review
        
        let realm = try! Realm()
        
        try! realm.write{
            realm.add(net)
        }
    }
}
