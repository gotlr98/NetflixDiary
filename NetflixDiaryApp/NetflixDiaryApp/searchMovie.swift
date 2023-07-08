//
//  searchMovie.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/06.
//

import Foundation
import UIKit

class searchMovie: UIViewController{
    
    var movie_title: String
    
    var title_url = [[String]]()
    
    init(movie_title: String){
        self.movie_title = movie_title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    override func viewDidLoad() {
        
        print(movie_title)
        
        requestNet(name: movie_title)
        
        print(title_url)
        
        let btn: UIButton = .init(frame: .init())
        
        
        btn.backgroundColor = .orange
        
        btn.setTitle("되돌아가기", for: .normal)
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        self.view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        btn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        
    }
    
    @objc func cancel(){
        self.navigationController?.popViewController(animated: true)
            let vc = self.navigationController?.viewControllers.last as! writeReviewModal
            vc.select_title = movie_title
    }
    
    func requestNet(name: String){
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOGNiMmEwNTRjYTZmMTEyZDY2YjFlODE2ZTIzOWVlNiIsInN1YiI6IjY0OWJkOWUwNzdjMDFmMDBjYTVhNzkwZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YXEMCu81V6_te2LwVDZiNCFrn1GUZeCcTAj4WYTGwug"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=ko-KR&page=1&sort_by=popularity.desc&with_watch_providers=providers%3A8")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let API_KEY = "e8cb2a054ca6f112d66b1e816e239ee6"
        var movieSearchURL = URLComponents(string: "https://api.themoviedb.org/3/search/movie?")

        // 쿼리 아이템 정의
        let apiQuery = URLQueryItem(name: "api_key", value: API_KEY)
        let languageQuery = URLQueryItem(name: "language", value: "ko-KR")
        let searchQuery = URLQueryItem(name: "query", value: name)
        
        movieSearchURL?.queryItems?.append(apiQuery)
        movieSearchURL?.queryItems?.append(languageQuery)
        movieSearchURL?.queryItems?.append(searchQuery)
        
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
//                      print("영화 제목 : \(i.title ?? "")")
//                      print("영화 평점 : \(i.rating ?? 0)")
//                      print("영화 줄거리 : \(i.summary ?? "")")
//                      print("포스터 경로 : \(i.post ?? "")")
//
//                      print("--------------------------")
                      
                      self.title_url.append([i.title!, i.post!])
                  }
                  
              }catch let error{
                  print(error.localizedDescription)
              }
          }
        })

        dataTask.resume()
    }


}
