//
//  SecondTabBar.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import Foundation
import UIKit

class SecondTabBar: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: false)
        
//        navigationController.item
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가하기", image: UIImage(systemName: "magnifyingglass"), target: nil, action: nil)

        self.navigationItem.rightBarButtonItem!.menu = UIMenu(children: [
                        UIAction(title: "리뷰쓰기", attributes: .destructive, handler: { _ in

                            self.navigationController?.pushViewController(writeReviewModal(), animated: true)
                        })
                    ])
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        
//        self.tabBarItem = UITabBarItem(title: "search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
