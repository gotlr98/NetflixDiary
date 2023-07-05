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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView: LottieAnimationView = .init(name: "netflix")
        self.view.addSubview(animationView)
        
        animationView.frame = self.view.bounds
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        
        animationView.play{ (finish) in
            print("animation finished")
            
            animationView.removeFromSuperview()

            self.requestNet()
            
            self.navigationController?.pushViewController(ViewController(), animated: false)

        }

    }
    
    func requestNet(){
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOGNiMmEwNTRjYTZmMTEyZDY2YjFlODE2ZTIzOWVlNiIsInN1YiI6IjY0OWJkOWUwNzdjMDFmMDBjYTVhNzkwZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YXEMCu81V6_te2LwVDZiNCFrn1GUZeCcTAj4WYTGwug"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=ko-KR&page=1&sort_by=popularity.desc&with_watch_providers=providers%3A8")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
              guard let resultData = data else { return }
              do{
                  let decoder = JSONDecoder()
                  let respons = try decoder.decode(Response.self, from: resultData)
                  let searchMovie = respons.result
                  
                  for i in searchMovie{
                      print("영화 제목 : \(i.title ?? "")")
                      print("영화 평점 : \(i.rating ?? 0)")
                      print("영화 줄거리 : \(i.summary ?? "")")
                      print("포스터 경로 : \(i.post ?? "")")
                      
                      print("--------------------------")
                  }
                  
                  
                  
              }catch let error{
                  print(error.localizedDescription)
              }
          }
        })

        dataTask.resume()
    }
}
