//
//  reviewCell.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/21.
//

import Foundation
import UIKit


class reviewCell: UITableViewCell{
    
    static let cell = "cell"
    
    let image = UIImageView()
    let name = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(image)
        self.addSubview(name)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        image.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // 3
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
        name.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
}
