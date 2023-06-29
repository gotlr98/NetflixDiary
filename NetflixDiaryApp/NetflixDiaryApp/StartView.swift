//
//  StartView.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import Foundation
import UIKit
import Lottie

class StartView: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView: LottieAnimationView = .init(name: "netflix")
        self.view.addSubview(animationView)
        
        animationView.frame = self.view.bounds
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        
        animationView.play{ (finish) in
            print("animation finished")
            
            animationView.removeFromSuperview()
            
            
            let main = ViewController()
            
            main.modalPresentationStyle = .fullScreen
            self.present(main, animated: false)

        }

    }
}
