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
        // Do any additional setup after loading the view.
        
//        self.navigationItem.prompt = "UITabBarController"
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가하기", image: UIImage(systemName: "plus"), target: nil, action: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationItem.rightBarButtonItem!.menu = UIMenu(children: [
//            UIAction(title: "리뷰쓰기", attributes: .destructive, handler: { _ in
////                let modal = writeReviewModal()
////                modal.modalPresentationStyle = .fullScreen
////                self.present(modal, animated: true)
//                
//                self.navigationController?.pushViewController(writeReviewModal(), animated: true)
//            })
//        ])
        
        self.navigationController?.isNavigationBarHidden = true
        let firstTab = UINavigationController(rootViewController: FirstTabBar())
        let tabone = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 1)
        firstTab.tabBarItem = tabone

        
        
        let secondTab = UINavigationController(rootViewController: SecondTabBar())
        let tabtwo = UITabBarItem(title: "search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        secondTab.tabBarItem = tabtwo
//        secondTab.tabBarController?.tabBar.isHidden = true
        
        let thirdTab = UINavigationController(rootViewController: ThirdTabBar())
        let tabthree = UITabBarItem(title: "profile", image: UIImage(systemName: "person.circle.fill"), tag: 3)
        thirdTab.tabBarItem = tabthree
        
        self.viewControllers = [firstTab, secondTab, thirdTab]
    }
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
//        self.view.backgroundColor = .white
//
//        let firstTab: UIViewController = FirstTabBar()
//        let secondTab: UIViewController = SecondTabBar()
//        let thirdTab: UIViewController = ThirdTabBar()
//
//        // Create an Array of Tables with Tabs as Elements.
//        let tabs = NSArray(objects: firstTab, secondTab, thirdTab)
//
//        // Set the ViewController.
//        self.setViewControllers(tabs as? [UIViewController], animated: false)
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
