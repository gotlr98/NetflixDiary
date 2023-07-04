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
}
