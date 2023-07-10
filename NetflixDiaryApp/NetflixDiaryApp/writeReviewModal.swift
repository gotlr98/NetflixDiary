//
//  writeReviewModal.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/05.
//

import Foundation
import UIKit
import SwiftUI
import ImageSlideshow
import ImageSlideshowKingfisher

protocol SendDataDelegate {
    func recieveData(img_url : [String]) -> Void
}


class writeReviewModal: UIViewController{
    
    var searchTextField: UITextField!
    var delegate: SendDataDelegate?
    var img_url: [String] = []
    var select_title: String = ""
    
    var searchButton: UIButton = .init(frame: .init())
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .gray
        
        let registerBtn: UIButton = .init(frame: .init())
        
        
        registerBtn.backgroundColor = .orange
        
        registerBtn.setTitle("등록하기", for: .normal)
        registerBtn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        self.view.addSubview(registerBtn)
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        registerBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        
        searchTextField = .init(frame: .init())
        
        searchTextField.placeholder = "검색할 작품을 입력해주세요"
        searchTextField.font = UIFont.systemFont(ofSize: 20)
        searchTextField.borderStyle = .line
        searchTextField.autocorrectionType = .no
        searchTextField.keyboardType = .default
        searchTextField.returnKeyType = .done
        searchTextField.autocapitalizationType = .none
//        searchTextField.delegate =
        
        self.view.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        searchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        
//        let searchButton: UIButton = .init(frame: .init())
        
//        let searchButton: UIButton = .init(frame: .init())
        
        searchButton.backgroundColor = .orange
        
//        searchButton.setTitle("닫기", for: .normal)
        searchButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        self.view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        searchButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
        let slide = ImageSlideshow()
        slide.setImageInputs([KingfisherSource(urlString: "https://image.tmdb.org/t/p/original/9WF6TxCYwdiZw51NM92ConaQz1w.jpg"),
                              KingfisherSource(urlString: "https://image.tmdb.org/t/p/original/9WF6TxCYwdiZw51NM92ConaQz1w.jpg")])

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if let sheetPresentationController = sheetPresentationController{
            sheetPresentationController.detents = [.medium(), .large()]
            
        }
        
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        
        print(self.select_title)
        
    }
    
    @objc func cancel(){
        self.dismiss(animated: true)
    }
    
    @objc func search(){
        
        let alert = UIAlertController(title: "Error", message: "검색어를 입력해 주세요", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(defaultAction)
        
        if let text = searchTextField.text, text.isEmpty{
            
            self.present(alert, animated: false)
            return
        }
        else{
            
//            requestNet(name: searchTextField.text!)
            
            let vc = searchMovie(movie_title: searchTextField.text!)
            
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    
        
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.windows[0].rootViewController

        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }

        return topMostViewController
    }
}


//
//#if DEBUG
//import SwiftUI
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//
//    // update
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
//
//    }
//    // makeui
//    @available(iOS 13.0, *)
//    func makeUIViewController(context: Context) -> UIViewController {
//        ViewController()
//    }
//}
//
//struct ViewController_Previews: PreviewProvider {
//    static var previews: some View{
//        ViewControllerRepresentable().previewDisplayName("아이폰 11")
//    }
//}
//#endif
