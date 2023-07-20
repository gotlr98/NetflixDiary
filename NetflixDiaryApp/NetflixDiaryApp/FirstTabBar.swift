//
//  FirstTabBar.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import SwiftUI
import Foundation
import UIKit

protocol reviewDelegate: AnyObject {
    func recieveData(title: String, img_url: String, review: String)
}

class FirstTabBar: UIViewController{
    
    
    var delegate: reviewDelegate?
    
    var select_title: String = ""
    var img_url: String = ""
    var review: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let scrollView: UIScrollView! = UIScrollView()
        let contentView: UIView! = UIView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.backgroundColor = .gray
        
//        scrollView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isDirectionalLockEnabled = true
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        
//        var config = UIButton.Configuration.tinted()
//        config.title = "Button"
//        config.image = UIImage(systemName: "swift")
//
//        let btn = UIButton(
//            configuration: config,
//            primaryAction: UIAction(handler: { _ in
//                print("button clicked")
//            })
//        )
        
        let registerBtn: UIButton = .init(frame: .init())
        
        registerBtn.backgroundColor = .orange
        
        registerBtn.setTitle("등록하기", for: .normal)
        registerBtn.addTarget(self, action: #selector(check), for: .touchUpInside)
        
        contentView.addSubview(registerBtn)
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        registerBtn.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        registerBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        let a: UIButton = .init(frame: .init())
        
        a.backgroundColor = .orange
        
        a.setTitle("등록하기", for: .normal)
        a.addTarget(self, action: #selector(check2), for: .touchUpInside)
        
        contentView.addSubview(a)
        a.translatesAutoresizingMaskIntoConstraints = false
        a.widthAnchor.constraint(equalToConstant: 120).isActive = true
        a.heightAnchor.constraint(equalToConstant: 60).isActive = true
        a.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        a.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
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
    
    @objc func check(){
//        print("\(self.img_url)\(self.title)\(self.review)")
        User().delete_all()
        //64b8cad0539de0f64821ca5d
//        User().set_user()
        
    }
    
    @objc func check2(){
        
    }
}

extension FirstTabBar: reviewDelegate {
    func recieveData(title: String, img_url: String, review: String) {
        self.select_title = title
        self.img_url = img_url
        self.review = review
    }
}

