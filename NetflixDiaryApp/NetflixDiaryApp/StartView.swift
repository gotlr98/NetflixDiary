//
//  StartView.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import Foundation
import UIKit
import Lottie

struct Response: Codable {
    let page: Int?
    let result: [MovieInfo]
    
    enum CodingKeys: String, CodingKey {
        case page
        case result = "results"
    }
}

struct MovieInfo: Codable {
    let title: String?
    let rating: Double?
    let summary: String?
    let post: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case rating = "vote_average"
        case summary = "overview"
        case post = "poster_path"
    }
}


class StartView: UIViewController{
    
    weak var delegate: sendMovieInfo?
    
    var movie_info = [[Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        findPopularFilm()
        
        let animationView: LottieAnimationView = .init(name: "netflix")
        self.view.addSubview(animationView)
        
        if User().get_user_count() == 0{
            User().set_user()
        }
        
        animationView.frame = self.view.bounds
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.play{ (finish) in
            
//            self.delegate?.recieveData(info: self.movie_info)
            
            let vc = ViewController()

            animationView.removeFromSuperview()
            
            self.navigationController?.pushViewController(ViewController(), animated: false)

        }
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
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

extension StartView: sendMovieInfo {
    func recieveData(info: [[Any]]){
        
        self.movie_info.append(info)
        
        print("func called")
        
    }
}
