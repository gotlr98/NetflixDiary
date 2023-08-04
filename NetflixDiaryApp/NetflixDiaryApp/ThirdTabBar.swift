//
//  ThirdTabBar.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import Foundation
import UIKit

class ThirdTabBar: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        
//        self.tabBarItem = UITabBarItem(title: "profile", image: UIImage(systemName: "person.circle.fill"), tag: 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
