//
//  ViewController.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/28.
//

import SwiftUI
import UIKit
import Lottie


class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        let firstTab = UINavigationController(rootViewController: FirstTabBar())
        let tabone = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 1)
        firstTab.tabBarItem = tabone
        
        
        let secondTab = UINavigationController(rootViewController: SecondTabBar())
        let tabtwo = UITabBarItem(title: "search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        secondTab.tabBarItem = tabtwo
                
        let thirdTab = UINavigationController(rootViewController: ThirdTabBar())
        let tabthree = UITabBarItem(title: "Empty", image: UIImage(systemName: "questionmark"), tag: 3)
        thirdTab.tabBarItem = tabthree
        
        self.viewControllers = [firstTab, secondTab, thirdTab]
        
        
        
    }
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init has not implemented")
    }
    
    @objc func rightClick(){
        self.navigationController?.pushViewController(writeReviewModal(), animated: true)
    }
    
    

}

struct Main: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController

    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
