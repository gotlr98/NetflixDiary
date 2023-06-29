//
//  ViewController.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/28.
//

import SwiftUI
import UIKit

class ViewController: UITabBarController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.prompt = "UITabBarController"
        
//        view.backgroundColor = .systemBackground
//
//        // [Label]
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
//        label.font = UIFont.preferredFont(forTextStyle: .title1)
//        label.textAlignment = .center
//        label.text = "Welcome to \n ViewController"
//
//        view.addSubview(label)
//
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
        
    }
    
    init(){ 
        super.init(nibName: nil, bundle: nil)
        
        let firstTab: UIViewController = FirstTabBar()
        let secondTab: UIViewController = SecondTabBar()
        let thirdTab: UIViewController = ThirdTabBar()
        
        // Create an Array of Tables with Tabs as Elements.
        let tabs = NSArray(objects: firstTab, secondTab, thirdTab)
        
        // Set the ViewController.
        self.setViewControllers(tabs as? [UIViewController], animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init has not implemented")
    }

}

struct ViewControllerRepresentable: UIViewControllerRepresentable {
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
        ViewControllerRepresentable()
    }
}
