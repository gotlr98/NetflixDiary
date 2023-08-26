//
//  popularMovieCell.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/08/09.
//

import Foundation
import UIKit

//protocol sendMovieInfo: AnyObject {
//    func recieveData(info: [[Any]])
//}


class popularMovieCell: UICollectionViewCell{
    
//    static let moviecell = "moviecell"
    
    static var id: String{ NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""}
    static var id2: String{ NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""}
    
    var delegate: sendMovieInfo?
    
    var movie_info = [[Any]]()
    
    var image = UIImageView()
    var name = UILabel()
    var comment = UILabel()
    var rating = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.addSubview(image)
        self.addSubview(name)
        self.addSubview(comment)
        self.addSubview(rating)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // 3
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        rating.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        
        comment.translatesAutoresizingMaskIntoConstraints = false
        comment.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20).isActive = true
        comment.widthAnchor.constraint(equalToConstant: 320).isActive = true
        comment.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        comment.numberOfLines = 0
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}

extension popularMovieCell: sendMovieInfo {
    func recieveData(info: [[Any]]){
        
        self.movie_info.append(info)
        
    }
}
