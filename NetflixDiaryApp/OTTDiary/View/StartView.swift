//
//  StartView.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import Foundation
import UIKit
import Lottie

struct MovieResponse: Codable {
    let page: Int?
    let result: [MovieInfo]
    
    enum CodingKeys: String, CodingKey {
        case page
        case result = "results"
    }
}

struct TvResponse: Codable {
    let page: Int?
    let result: [TvInfo]
    
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

struct TvInfo: Codable {
    let name: String?
    let rating: Double?
    let summary: String?
    let post: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case rating = "vote_average"
        case summary = "overview"
        case post = "poster_path"
    }
}



class StartView: UIViewController{
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setAnimation()
        
    
    }
    
    func setAnimation(){
        let animationView: LottieAnimationView = .init(name: "netflix")
        self.view.addSubview(animationView)
        
        if User().get_user_count() == 0{
            User().set_user()
        }
        animationView.frame = self.view.bounds
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.play{ (finish) in
                        
            animationView.removeFromSuperview()
            
            self.navigationController?.pushViewController(ViewController(), animated: false)
        }
    }
    
    
    
}
