//
//  SecondTabBar.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import Foundation
import UIKit



class SecondTabBar: UIViewController{
    
//    let pop = popularMoviewView()
    
    var delegate: sendMovieInfo?
    
    var movie = [[String]]()
    
    lazy var collectionView: UICollectionView = {
       
        
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        
        lay.minimumLineSpacing = 50
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: lay)
        view.backgroundColor = .white
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refresh = UIRefreshControl()

        refresh.addTarget(self, action: #selector(getData), for: .valueChanged)
        
        self.collectionView.refreshControl = refresh
        
        view.addSubview(collectionView)
        
        
        
        if self.movie.isEmpty{
            getData()

        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
        }
        
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.register(popularMovieCell.self, forCellWithReuseIdentifier: popularMovieCell.id)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가하기", image: UIImage(systemName: "magnifyingglass"), target: nil, action: nil)

        self.navigationItem.rightBarButtonItem!.menu = UIMenu(children: [
                        UIAction(title: "리뷰쓰기", attributes: .destructive, handler: { _ in

                            self.navigationController?.pushViewController(writeReviewModal(), animated: true)
                        })
                    ])
        
//        if self.movie.isEmpty{
//            print(FirstTabBar().movie_info)
//            self.movie = FirstTabBar().movie_info
//        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.movie)
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func getData(){
        
        var timer: Int = 0
        
        findPopularFilm()
        
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
}

extension SecondTabBar: sendMovieInfo {
    
    func recieveData(info: [[Any]]) {
//        self.movie = info
    }
}

extension SecondTabBar: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularMovieCell.id, for: indexPath)
        if let cell = cell as? popularMovieCell {
            cell.name.text = movie[indexPath.item][0]
            cell.rating.text = movie[indexPath.item][1]
            cell.comment.text = movie[indexPath.item][2]
            cell.image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w220_and_h330_face" + movie[indexPath.item][3]))
        }

        return cell
    }
}

extension SecondTabBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: collectionView.frame.height) // point
    }
}
