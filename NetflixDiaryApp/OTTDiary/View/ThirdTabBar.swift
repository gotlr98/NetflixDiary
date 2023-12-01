//
//  ThirdTabBar.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import Foundation
import UIKit

class ThirdTabBar: UIViewController{
    
    let label1 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(label1)
        label1.translatesAutoresizingMaskIntoConstraints = false
        
        label1.text = "Coming Soon...."
        
        NSLayoutConstraint.activate([
            label1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
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
