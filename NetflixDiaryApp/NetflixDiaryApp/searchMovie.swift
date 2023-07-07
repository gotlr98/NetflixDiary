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
    
    init(movie_title: String){
        self.movie_title = movie_title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    override func viewDidLoad() {
        
        print(movie_title)
    }
    

}
