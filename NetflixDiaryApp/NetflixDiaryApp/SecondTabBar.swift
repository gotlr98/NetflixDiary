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
    
    var tv = [[String]]()
    
    
    lazy var popularMovie: UICollectionView = {
       
        
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        
        lay.minimumLineSpacing = 50
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: lay)
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var popularTV: UICollectionView = {
       
        
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
        
        self.popularMovie.refreshControl = refresh
        
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isDirectionalLockEnabled = true
                
        
        let contentView = UIView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.backgroundColor = .white
        
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
        
        contentView.addSubview(popularMovie)
        
        contentView.addSubview(popularTV)
        
        
        
        if self.movie.isEmpty{
            findPopular(kind: "movie")
            
            

        }
        
        else if self.tv.isEmpty{
            
            findPopular(kind: "TV")
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
        }
        
        
        popularMovie.delegate = self
        
        popularMovie.dataSource = self
        
        popularMovie.register(popularMovieCell.self, forCellWithReuseIdentifier: popularMovieCell.id)
        
        popularMovie.translatesAutoresizingMaskIntoConstraints = false
        
        popularMovie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        popularMovie.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        popularMovie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        popularMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        popularMovie.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        
        popularTV.delegate = self
        
        popularTV.dataSource = self
        
        popularTV.register(popularMovieCell.self, forCellWithReuseIdentifier: popularMovieCell.id)
        
        popularTV.translatesAutoresizingMaskIntoConstraints = false
        
        popularTV.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        popularTV.topAnchor.constraint(equalTo: self.popularMovie.bottomAnchor, constant: 50).isActive = true
        popularTV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        popularTV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        popularTV.heightAnchor.constraint(equalToConstant: 400).isActive = true
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가하기", image: UIImage(systemName: "magnifyingglass"), target: nil, action: nil)

        self.navigationItem.rightBarButtonItem!.menu = UIMenu(children: [
                        UIAction(title: "리뷰쓰기", attributes: .destructive, handler: { _ in

                            self.navigationController?.pushViewController(writeReviewModal(), animated: true)
                        })
                    ])


    }
    
    override func viewDidAppear(_ animated: Bool) {
//        print(self.movie)
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func getData(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.findPopular(kind: "movie")
            self.popularMovie.refreshControl?.endRefreshing()
            
        }
        
        
    }
    
    @objc func findPopular(kind: String) {

        let API_KEY = "e8cb2a054ca6f112d66b1e816e239ee6"
        var movieSearchURL = URLComponents(string: "https://api.themoviedb.org/3/discover/\(kind)?")

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
                          
                          if kind == "movie"{
                              self.movie.append([a,b,c,d])
                          }
                          
                          else{
                              self.tv.append([a,b,c,d])
                          }
                          
                          
                                                    
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
        
        if collectionView == self.popularMovie{
            return movie.count
        }
        
        else{
            return tv.count
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.popularMovie{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularMovieCell.id, for: indexPath)
            if let cell = cell as? popularMovieCell {
                cell.name.text = movie[indexPath.item][0]
                cell.rating.text = movie[indexPath.item][1]
                if movie[indexPath.item][2].isEmpty{
                    cell.comment.text = "줄거리가 비었습니다"
                }
                else{
                    cell.comment.text = movie[indexPath.item][2]

                }
                cell.image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w220_and_h330_face" + movie[indexPath.item][3]))
            }

            return cell
        }
        
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularMovieCell.id2, for: indexPath)
            if let cell = cell as? popularMovieCell {
                cell.name.text = tv[indexPath.item][0]
                cell.rating.text = tv[indexPath.item][1]
                if tv[indexPath.item][2].isEmpty{
                    cell.comment.text = "줄거리가 비었습니다"
                }
                else{
                    cell.comment.text = tv[indexPath.item][2]

                }
                cell.image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w220_and_h330_face" + tv[indexPath.item][3]))
            }

            return cell
        }
        
        
    }
}

extension SecondTabBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: collectionView.frame.height) // point
    }
}
