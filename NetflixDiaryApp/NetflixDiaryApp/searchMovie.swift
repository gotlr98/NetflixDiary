//
//  searchMovie.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/06.
//

import Foundation
import UIKit
import ImageSlideshow
import ImageSlideshowKingfisher

class searchMovie: UIViewController{
    
    var move_title_url: [String:String]
    
    var title_url: [KingfisherSource] = []
    weak var delegate: SendDataDelegate?
    
    let slide: ImageSlideshow = {
        let slide = ImageSlideshow()
        slide.isUserInteractionEnabled = true
        slide.contentScaleMode = .scaleAspectFill
        
        return slide
    }()
    
    let indicator = LabelPageIndicator()
    
    init(a: [String:String]){
        self.move_title_url = a
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    override func viewDidLoad() {
        
        
        self.view.backgroundColor = .yellow
        
        for i in move_title_url.values{
            let a = "https://image.tmdb.org/t/p/w220_and_h330_face" + i
            title_url.append(KingfisherSource(urlString: a, placeholder: .checkmark)!)
        }
        
        
        indicator.textColor = .white
        
        slide.pageIndicator = indicator
        slide.setImageInputs(title_url)
        
        slide.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(slide)
        
        NSLayoutConstraint.activate([
            slide.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            slide.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            slide.topAnchor.constraint(equalTo: self.view.topAnchor),
            slide.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTab(sender: )))
        slide.addGestureRecognizer(gesture)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.title_url.isEmpty{
            move_title_url = writeReviewModal().title_url
        }
    }
    
    
    @objc func didTab(sender: UITapGestureRecognizer? = nil){
        let num = self.indicator.page
        let index = move_title_url.index(move_title_url.startIndex, offsetBy: num)

        delegate?.recieveData(title: move_title_url.keys[index])

        dismiss(animated: true)
    }


}
