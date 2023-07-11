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
        
//        requestNet(name: movie_title)
        
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
    
    


}
