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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let scrollView: UIScrollView! = UIScrollView()
        let contentView: UIView! = UIView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.backgroundColor = .blue
        
        scrollView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        
        
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        
        var config = UIButton.Configuration.tinted()
        config.title = "Button"
        config.image = UIImage(systemName: "swift")
        
        let btn = UIButton(
            configuration: config,
            primaryAction: UIAction(handler: { _ in
                print("button clicked")
            })
        )
        
        
//        self.navigationController!.title = "NavigationTitle"
//        contentView.addSubview(btn)
//        
//        btn.showsMenuAsPrimaryAction = true
//        btn.menu = UIMenu(children: [
//            UIAction(title: "remove", attributes: .destructive, handler: { _ in
//                print("remove clicked")
//            })
//        ])
//                
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        
//        btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
//        btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
//        
//        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        btn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        
        self.tabBarItem = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    func toolbar(){
//
//        self.navigationController?.isToolbarHidden = false
//
//        var shareButton: UIBarButtonItem!
//        var trashButton: UIBarButtonItem!
//    }
    
    func makeButton(){
        
        var button = UIButton()
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
    
    
    
}


