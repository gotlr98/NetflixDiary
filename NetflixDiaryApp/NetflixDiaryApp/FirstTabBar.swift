//
//  FirstTabBar.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import SwiftUI
import Foundation
import UIKit


class FirstTabBar: UIViewController{
    
    var button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = .black
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        
        self.tabBarItem = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}


