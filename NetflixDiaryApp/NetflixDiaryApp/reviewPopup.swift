//
//  reviewPopup.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/26.
//

import Foundation
import UIKit


class reviewPopup: UIViewController, UITextViewDelegate{
    
    var movie_title: String
    var img_url: String
    var review: String
    
    lazy var review_view: UITextView = {
        
        let text = UITextView()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.delegate = self
        
        return text
    }()
    
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
        
        self.view.backgroundColor = .white
        
        let title_label = UILabel()
        
        self.view.addSubview(title_label)
        
        
        title_label.text = "' " + movie_title + " ' " + "리뷰: "
        title_label.translatesAutoresizingMaskIntoConstraints = false
        
        
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
        
        
        
        title_label.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -10).isActive = true
        title_label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        title_label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        title_label.widthAnchor.constraint(equalToConstant: 300).isActive = true

        
        self.view.addSubview(review_view)
        
        review_view.text = self.review
        review_view.textColor = .black
        review_view.font = UIFont(name: "Callout", size: 50)
        
        review_view.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true
        review_view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        review_view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        review_view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
}
