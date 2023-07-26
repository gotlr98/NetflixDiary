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
    let review: String
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
                let post = Poster(image_url: i.img_url, title: i.title, review: i.review)
                empty.append(post)
            }
            poster = empty
        }
        
        self.table.reloadData()
    }

    
    @objc func check(){
        User().delete_all()
        
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
        
        let vc = reviewPopup(movie_title: gesture.title!, img_url: gesture.img_url!, review: gesture.review!)
        
        self.present(vc, animated: true)
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
        gesture.img_url = poster[indexPath.row].image_url
        gesture.review = poster[indexPath.row].review
        
        cell.addGestureRecognizer(gesture)
        
        return cell
    }
}

class CustomTapGesture: UITapGestureRecognizer {
    var title: String?
    var img_url: String?
    var review: String?
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
