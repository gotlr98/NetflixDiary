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
//
//        requestNet(name: movie_title)
//
//        print(title_url)
//
//        let btn: UIButton = .init(frame: .init())
//
//
//        btn.backgroundColor = .orange
//
//        btn.setTitle("되돌아가기", for: .normal)
//        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
//
//        self.view.addSubview(btn)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        btn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
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
    
    @objc func cancel(){

    }
    
    @objc func didTab(sender: UITapGestureRecognizer? = nil){
        let num = self.indicator.page
        let index = move_title_url.index(move_title_url.startIndex, offsetBy: num)
        
//        self.navigationController?.popViewController(animated: true)
        
//        if let viewcon = presentingViewController as? writeReviewModal{
//            viewcon.select_title = move_title_url.keys[index]
//        }
        delegate?.recieveData(title: move_title_url.keys[index])
//        let vc = writeReviewModal()
//        vc.select_title = move_title_url.keys[index]
//        print(move_title_url.keys[index])
        
//        if let vc = presentingViewController as? writeReviewModal{
//            vc.reloadInputViews()
//            print("vc appear")
//        }
        dismiss(animated: true)
    }


}
