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
        
        
        DispatchQueue.main.async(execute: {
            self.findPopular(kind: "movie")
            self.findPopular(kind: "tv")
        })
        
        
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
        
        popularMovie.layer.borderColor = UIColor.orange.cgColor
        popularTV.layer.borderColor = UIColor.orange.cgColor
        
        popularMovie.layer.borderWidth = 3
        popularTV.layer.borderWidth = 3

        
        
        let title1 = UILabel()
        let title2 = UILabel()
        
        contentView.addSubview(title1)
        contentView.addSubview(title2)
        
        title1.translatesAutoresizingMaskIntoConstraints = false
        title2.translatesAutoresizingMaskIntoConstraints = false
        
        title1.text = " 인기있는 영화"
        title2.text = " 인기있는 TV시리즈"
        
        
        title1.layer.borderColor = UIColor.lightGray.cgColor
        title2.layer.borderColor = UIColor.lightGray.cgColor
        
        title1.layer.borderWidth = 3
        title2.layer.borderWidth = 3
        
        popularMovie.delegate = self
        
        popularMovie.dataSource = self
        
        popularMovie.register(popularMovieCell.self, forCellWithReuseIdentifier: popularMovieCell.id)
        
        popularMovie.translatesAutoresizingMaskIntoConstraints = false
        
        popularMovie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        popularMovie.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 90).isActive = true
        popularMovie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        popularMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        popularMovie.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        title1.bottomAnchor.constraint(equalTo: popularMovie.topAnchor, constant: -30).isActive = true
        title1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        title1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        title1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        popularTV.delegate = self
        
        popularTV.dataSource = self
        
        popularTV.register(popularMovieCell.self, forCellWithReuseIdentifier: popularMovieCell.id)
        
        popularTV.translatesAutoresizingMaskIntoConstraints = false
        
        popularTV.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        popularTV.topAnchor.constraint(equalTo: self.popularMovie.bottomAnchor, constant: 50).isActive = true
        popularTV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        popularTV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        popularTV.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        title2.bottomAnchor.constraint(equalTo: popularMovie.topAnchor, constant: -30).isActive = true
        title2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        title2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        title2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.updateContentSize()
        

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
//            self.findPopular(kind: "movie")
//            self.popularMovie.refreshControl?.endRefreshing()
            
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


                          if kind == "movie"{

                              let a = String(i.title!)
                              let b = String(i.rating!)
                              let c = String(i.summary!)
                              let d = String(i.post!)

                              self.movie.append([a,b,c,d])

                          }

                          else{

                              var empty: [String] = []


                              if let a = i.title{
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



                      }

                  }catch let error{
                      print(error.localizedDescription)
                  }
              }
            })
            dataTask.resume()

    }
}

//extension SecondTabBar: sendMovieInfo {
//    
//    func recieveData(info: [[Any]]) {
////        self.movie = info
//    }
//}

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


extension UIScrollView {
    func updateContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        
        // 계산된 크기로 컨텐츠 사이즈 설정
        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height+50)
    }
    
    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
        
        // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        
        // 최종 계산 영역의 크기를 반환
        return totalRect.union(view.frame)
    }
}
