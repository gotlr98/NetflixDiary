//
//  FirstTabBar.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import SwiftUI
import Foundation
import UIKit
import Kingfisher

//protocol reviewDelegate: AnyObject {
//    func recieveData(title: String, img_url: String, review: String)
//}

struct Poster{
    let image_url: String
    let title: String
}

class FirstTabBar: UIViewController{
    
    
    var poster: [Poster] = []
    
//    let img = UIImageView().kf.setImage(with: URL(string: ""))
    
    let table = UITableView()
    
    
    var select_title: String = ""
    var img_url: String = ""
    var review: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        table.delegate = self
        table.dataSource = self
        
        table.register(reviewCell.self, forCellReuseIdentifier: reviewCell.cell)
        
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        
        
//        let scrollView: UIScrollView! = UIScrollView()
//        let contentView: UIView! = UIView()
//
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//
//        contentView.backgroundColor = .gray
//
//        scrollView.showsVerticalScrollIndicator = true
//        scrollView.isDirectionalLockEnabled = true
//
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
//            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
//        ])
//
//        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//
//        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
//
//        contentViewHeight.priority = .defaultLow
//        contentViewHeight.isActive = true

        
//        let registerBtn: UIButton = .init(frame: .init())
//
//        registerBtn.backgroundColor = .orange
//
//        registerBtn.setTitle("등록하기", for: .normal)
//        registerBtn.addTarget(self, action: #selector(check), for: .touchUpInside)
//
//        contentView.addSubview(registerBtn)
//        registerBtn.translatesAutoresizingMaskIntoConstraints = false
//        registerBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        registerBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        registerBtn.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        registerBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//
//        let a: UIButton = .init(frame: .init())
//
//        a.backgroundColor = .orange
//
//        a.setTitle("등록하기", for: .normal)
//        a.addTarget(self, action: #selector(check2), for: .touchUpInside)
//
//        contentView.addSubview(a)
//        a.translatesAutoresizingMaskIntoConstraints = false
//        a.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        a.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        a.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        a.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        
        self.tabBarItem = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let net = User().get_user_net()
        
        var empty: [Poster] = []
        
        if !net.isEmpty && (net.count != poster.count){
            for i in net{
                let post = Poster(image_url: i.img_url, title: i.title)
                empty.append(post)
            }
            poster = empty
        }
        
        self.table.reloadData()
    }
    
//    func toolbar(){
//
//        self.navigationController?.isToolbarHidden = false
//
//        var shareButton: UIBarButtonItem!
//        var trashButton: UIBarButtonItem!
//    }
    
    
    @objc func check(){
//        print("\(self.img_url)\(self.title)\(self.review)")
        User().delete_all()
        //64b8cad0539de0f64821ca5d
//        User().set_user()
        
    }
    
    @objc func check2(){
        
        User().add_user_net(net: Netflix(title: "어벤져스", img_url: "asdf", review: "sdfdf"))
        let net = User().get_user_net()
        
        print(net)
        
        
        User().delete_net(title: "어벤져스")
        
        let user_net = User().get_user_net()
        
        print(user_net)
    }
    
    @objc func cellTap(gesture: CustomTapGesture){
        print(gesture.title)
    }
}

extension FirstTabBar:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.poster.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reviewCell.cell, for: indexPath) as! reviewCell
        
        cell.image.kf.setImage(with: URL(string: poster[indexPath.row].image_url))
        cell.name.text = poster[indexPath.row].title
        
        let gesture = CustomTapGesture(target: self, action: #selector(self.cellTap(gesture:)))
        gesture.title = poster[indexPath.row].title
        
        cell.addGestureRecognizer(gesture)
        
        return cell
    }
}

class CustomTapGesture: UITapGestureRecognizer {
  var title: String?
}


//
//extension FirstTabBar: reviewDelegate {
//    func recieveData(title: String, img_url: String, review: String) {
//        self.select_title = title
//        self.img_url = img_url
//        self.review = review
//    }
//}
//
