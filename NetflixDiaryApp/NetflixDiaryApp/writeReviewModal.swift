//
//  writeReviewModal.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/05.
//

import Foundation
import UIKit
import SwiftUI


class writeReviewModal: UIViewController{
    
    var searchTextField: UITextField!
    
    override func viewDidLoad() {
        if let sheetPresentationController = sheetPresentationController{
            sheetPresentationController.detents = [.medium(), .large()]
            
        }
        
        self.view.backgroundColor = .gray
        
        let cancelBtn: UIButton = .init(frame: .init())
        let registerBtn: UIButton = .init(frame: .init())
        
        cancelBtn.backgroundColor = .orange
        
        cancelBtn.setTitle("닫기", for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        self.view.addSubview(cancelBtn)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        cancelBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cancelBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        cancelBtn.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        
        registerBtn.backgroundColor = .orange
        
        registerBtn.setTitle("등록하기", for: .normal)
        registerBtn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        self.view.addSubview(registerBtn)
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        registerBtn.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        
        
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
        
        let searchButton: UIButton = .init(frame: .init())
        
        searchButton.backgroundColor = .orange
        
        searchButton.setTitle("닫기", for: .normal)
        searchButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        self.view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        searchButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
    }
    
    @objc func cancel(){
        self.dismiss(animated: true)
    }
    
    @objc func search(){
        guard let text = searchTextField.text else{
            return
        }
        print(text)
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
