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
    
    static let moviecell = "moviecell"
    
    var delegate: sendMovieInfo?
    
    var movie_info = [[Any]]()
    
    let image = UIImageView()
    let name = UILabel()
    let comment = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.addSubview(image)
        self.addSubview(name)
        self.addSubview(comment)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // 3
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        
        comment.translatesAutoresizingMaskIntoConstraints = false
        comment.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20).isActive = true
            
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
