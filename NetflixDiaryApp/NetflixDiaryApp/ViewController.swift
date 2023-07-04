//
//  ViewController.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/28.
//

import SwiftUI
import UIKit
import Lottie


class ViewController: UITabBarController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.prompt = "UITabBarController"
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가하기", image: UIImage(systemName: "swift"), target: nil, action: Selector("hi"))
        navigationItem.rightBarButtonItem!.menu = UIMenu(children: [
            UIAction(title: "remove", attributes: .destructive, handler: { _ in
                print("remove clicked")
            })
        ])
        
        
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
