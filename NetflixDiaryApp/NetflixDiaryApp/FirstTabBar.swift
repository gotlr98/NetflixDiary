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
    
    
    let table = UITableView()
    
    
    var select_title: String = ""
    var img_url: String = ""
    var review: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        let rightbarbutton = UIBarButtonItem(title: "추가하기", image: UIImage(systemName: "plus"), target: nil, action: #selector(rightClick))
//
//        
//        self.navigationController?.navigationItem.setRightBarButton(rightbarbutton, animated: true)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가하기", image: UIImage(systemName: "plus"), target: nil, action: nil)
        
        
        
        
        NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.didDismissDetailNotification(_:)),
                  name: NSNotification.Name("DismissModal"),
                  object: nil
              )
        
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
        
        table.rowHeight = 60

    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        
//        self.tabBarItem = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let refresh = UIRefreshControl()

        refresh.addTarget(self, action: #selector(getData), for: .valueChanged)
        
        self.table.refreshControl = refresh
        
        let navigationTitle = UILabel()
        
        navigationTitle.text = "나의 리뷰"
        navigationTitle.font = UIFont.systemFont(ofSize: 20)
        navigationTitle.textAlignment = .left
        
        self.navigationItem.titleView = navigationTitle

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가하기", image: UIImage(systemName: "plus"), target: nil, action: nil)

        self.navigationItem.rightBarButtonItem!.menu = UIMenu(children: [
                        UIAction(title: "리뷰쓰기", attributes: .destructive, handler: { _ in

                            self.navigationController?.pushViewController(writeReviewModal(), animated: true)
                        })
                    ])

        
//        self.tabBarController?.navigationItem.titleView = navigationTitle
//        
//        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가하기", image: UIImage(systemName: "plus"), target: nil, action: nil)
//
//        self.tabBarController?.navigationItem.rightBarButtonItem!.menu = UIMenu(children: [
//                        UIAction(title: "리뷰쓰기", attributes: .destructive, handler: { _ in
//            //                let modal = writeReviewModal()
//            //                modal.modalPresentationStyle = .fullScreen
//            //                self.present(modal, animated: true)
//
//                            self.navigationController?.pushViewController(writeReviewModal(), animated: true)
//                        })
//                    ])

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
    
    @objc func rightClick(){
        self.navigationController?.pushViewController(writeReviewModal(), animated: true)
    }
    
    @objc func getData(){
        
        print("refresh")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.table.refreshControl?.endRefreshing()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        navigationItem.rightBarButtonItem!.menu = UIMenu(children: [
//            UIAction(title: "리뷰쓰기", attributes: .destructive, handler: { _ in
////                let modal = writeReviewModal()
////                modal.modalPresentationStyle = .fullScreen
////                self.present(modal, animated: true)
//
//                self.navigationController?.pushViewController(writeReviewModal(), animated: true)
//            })
//        ])
    }
    
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            
            let net = User().get_user_net()
            
            var temp: [Poster] = []
            
            for i in net{
                let post = Poster(image_url: i.img_url, title: i.title, review: i.review)
                temp.append(post)
            }
            
            self.poster = temp
            self.table.reloadData()
        }
    }
    
    @objc func cellTap(gesture: CustomTapGesture){
        
        let vc = reviewPopup(movie_title: gesture.title!, img_url: gesture.img_url!, review: gesture.review!)
        
        vc.modalPresentationStyle = .formSheet
        
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
        
        cell.backgroundColor = .gray
                
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
