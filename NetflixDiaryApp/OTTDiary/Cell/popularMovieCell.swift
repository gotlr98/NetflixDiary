//
//  popularMovieCell.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/08/09.
//

import Foundation
import UIKit


class popularMovieCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout{
    
    
    static var id: String{ NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""}
    static var id2: String{ NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""}
    
    
    var movie_info = [[Any]]()
    
    var image = UIImageView()
    var name = UILabel()
    var comment = UILabel()
    var rating = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isDirectionalLockEnabled = true
        
        
        
        let contentView = UIView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.backgroundColor = UIColor(hexCode: "e0ffff")
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
                
        contentView.addSubview(image)
        contentView.addSubview(name)
        contentView.addSubview(comment)
        contentView.addSubview(rating)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // 3
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        rating.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        
        comment.translatesAutoresizingMaskIntoConstraints = false
        comment.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 25).isActive = true
        comment.widthAnchor.constraint(equalToConstant: 320).isActive = true
        comment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        comment.numberOfLines = 0
        
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
