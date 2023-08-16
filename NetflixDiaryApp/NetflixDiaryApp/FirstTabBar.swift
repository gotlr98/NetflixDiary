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

protocol sendMovieInfo: AnyObject {
    func recieveData(info: [[Any]])
}

class FirstTabBar: UIViewController{
    
    
    var poster: [Poster] = []
    
    let vc = SecondTabBar()
    
    weak var delegate: sendMovieInfo?
    var movie_info = [[Any]]()
    
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
        
        
        self.delegate = vc
        
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
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.delegate?.recieveData(info: self.movie_info)
        }
        
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
        
        var timer = 0
        
        if timer == 0{
            findPopularFilm()
            timer += 1
        }
        
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
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
    
    @objc func findPopularFilm() {

        let API_KEY = "e8cb2a054ca6f112d66b1e816e239ee6"
        var movieSearchURL = URLComponents(string: "https://api.themoviedb.org/3/discover/movie?")

        // 쿼리 아이템 정의
        let apiQuery = URLQueryItem(name: "api_key", value: API_KEY)
        let languageQuery = URLQueryItem(name: "language", value: "ko-KR")
        let watchProvider = URLQueryItem(name: "with_watch_providers", value: "8")

        movieSearchURL?.queryItems?.append(apiQuery)
        movieSearchURL?.queryItems?.append(languageQuery)
        movieSearchURL?.queryItems?.append(watchProvider)
        
        guard let requestMovieSearchURL = movieSearchURL?.url else { return }
        
        let config = URLSessionConfiguration.default

        // session 설정
        let session = URLSession(configuration: config)
        
        let dataTask = session.dataTask(with: requestMovieSearchURL, completionHandler: { (data, response, error) -> Void in
              if (error != nil) {
                print(error as Any)
              } else {
                  guard let resultData = data else { return }
                  do{
                      let decoder = JSONDecoder()
                      let respons = try decoder.decode(Response.self, from: resultData)
                      let searchMovie = respons.result
                      
                      for i in searchMovie{
//                          print("영화 제목 : \(i.title ?? "")")
//                          print("영화 평점 : \(i.rating ?? 0)")
//                          print("영화 줄거리 : \(i.summary ?? "")")
//                          print("포스터 경로 : \(i.post ?? "")")
//
//                          print("--------------------------")
                          let a = [i.title!, i.rating!, i.summary!, i.post!]
                          self.movie_info.append(a)
                                            
                      }
                      
                  }catch let error{
                      print(error.localizedDescription)
                  }
              }
            })
            dataTask.resume()
        
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
