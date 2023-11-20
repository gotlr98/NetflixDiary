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

protocol reviewDelegate: AnyObject {
    func recieveData(title: String, img_url: String, review: String)
}

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
    
    
    weak var delegate: sendMovieInfo?
    var movie_info = [[Any]]()
    
    
    var movie = [[String]]()
    var tv = [[String]]()
    
    let table = UITableView()
    
    
    var select_title: String = ""
    var img_url: String = ""
    var review: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        findPopularMovie()
        findPopularTV()
                

        
        NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.didDismissDetailNotification(_:)),
                  name: NSNotification.Name("DismissModal"),
                  object: nil
              )
        
        setTable()

        
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        
        
//        self.tabBarItem = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        let refresh = UIRefreshControl()

//        refresh.addTarget(self, action: #selector(getData), for: .valueChanged)
        
//        self.table.refreshControl = refresh
        
        
        setNavigation()


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
    
//    @objc func getData(){
//
//        print("refresh")
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.table.refreshControl?.endRefreshing()
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
                

        let bar = self.tabBarController?.viewControllers
        
        let svc = (bar![1] as! UINavigationController).viewControllers[0] as! SecondTabBar
        
        svc.tv = tv
        svc.movie = movie
        
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
    
    @objc func findPopularMovie() {

        let API_KEY = Bundle.main.apiKey
        var movieSearchURL = URLComponents(string: "https://api.themoviedb.org/3/discover/movie?")

        // 쿼리 아이템 정의
        let apiQuery = URLQueryItem(name: "api_key", value: API_KEY)
        let languageQuery = URLQueryItem(name: "language", value: "ko-KR")
        
        let watchProvider = URLQueryItem(name: "with_watch_providers", value: "8")
        let region = URLQueryItem(name: "region", value: "KR")
        

        movieSearchURL?.queryItems?.append(apiQuery)
        movieSearchURL?.queryItems?.append(languageQuery)
        movieSearchURL?.queryItems?.append(watchProvider)
        movieSearchURL?.queryItems?.append(region)

        
        
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
                      let respons = try decoder.decode(MovieResponse.self, from: resultData)
                      let searchMovie = respons.result
                      
                      for i in searchMovie{

                          
                              
                          let a = String(i.title!)
                          let b = String(i.rating!)
                          let c = String(i.summary!)
                          let d = String(i.post!)
                          
                          
                          self.movie.append([a,b,c,d])                                         
                      }
                      
                  }catch let error{
                      print(error.localizedDescription)
                  }
              }
            })
            dataTask.resume()
        
    }
    
    func findPopularTV(){
        
        let API_KEY = Bundle.main.apiKey
        var movieSearchURL = URLComponents(string: "https://api.themoviedb.org/3/discover/tv?")

        // 쿼리 아이템 정의
        let apiQuery = URLQueryItem(name: "api_key", value: API_KEY)
        let languageQuery = URLQueryItem(name: "language", value: "ko-KR")
        let network = URLQueryItem(name: "with_networks", value: "213")
        let region = URLQueryItem(name: "region", value: "KR")
            
        movieSearchURL?.queryItems?.append(apiQuery)
        movieSearchURL?.queryItems?.append(languageQuery)
        movieSearchURL?.queryItems?.append(network)
        movieSearchURL?.queryItems?.append(region)
        
        
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
                      let respons = try decoder.decode(TvResponse.self, from: resultData)
                      let searchTv = respons.result
                      
                      for i in searchTv{

                          var empty: [String] = []
                          
                          
                          if let a = i.name{
                              empty.append(String(a))
                          }
                          else{
                              empty.append("empty")
                          }
                          
                          
                          if let b = i.rating{
                              empty.append(String(b))
                          }
                          else{
                              empty.append("empty")
                          }
                          
                          if let c = i.summary{
                              empty.append(String(c))
                          }
                          else{
                              empty.append("empty")
                          }
                          
                          if let d = i.post{
                              empty.append(String(d))
                          }
                          else{
                              empty.append("empty")
                          }
                          
                          self.tv.append(empty)
                      }
                      
                  }catch let error{
                      print(error.localizedDescription)
                  }
              }
            })
            dataTask.resume()
        
        
        
    }
    
    func setNavigation(){
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
    }
    
    func setTable(){
        self.table.backgroundColor = .white
        
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

