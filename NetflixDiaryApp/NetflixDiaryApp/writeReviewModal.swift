//
//  writeReviewModal.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/05.
//

import Foundation
import UIKit

class writeReviewModal: UIViewController{
    
    override func viewDidLoad() {
        if let sheetPresentationController = sheetPresentationController{
            sheetPresentationController.detents = [.medium(), .large()]
            
        }
        
        self.view.backgroundColor = .gray
        
        let cancelBtn = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        cancelBtn.backgroundColor = .blue
        cancelBtn.setTitle("닫기", for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        self.view.addSubview(cancelBtn)
    }
    
    @objc func cancel(){
        self.dismiss(animated: true)
    }
}
