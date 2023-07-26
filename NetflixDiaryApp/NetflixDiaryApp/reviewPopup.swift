//
//  reviewPopup.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/26.
//

import Foundation
import UIKit


class reviewPopup: UIViewController{
    
    var movie_title: String
    var img_url: String
    var review: String
    
    init(movie_title: String, img_url: String, review: String){
        
        self.movie_title = movie_title
        self.img_url = img_url
        self.review = review
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init error occur")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImageView()
        
        self.view.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        image.kf.setImage(
            with: URL(string: img_url),
            placeholder: nil
        )
        
        let review_view = UITextView()
        
        self.view.addSubview(review_view)
        
        review_view.text = review
        review_view.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true
        review_view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
