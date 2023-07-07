//
//  writeReviewModal.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/05.
//

import Foundation
import UIKit
import SwiftUI

protocol SendDataDelegate {
    func recieveData(img_url : [String]) -> Void
}


class writeReviewModal: UIViewController{
    
    var searchTextField: UITextField!
    var delegate: SendDataDelegate?
    var img_url: [String] = []
    
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

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if let sheetPresentationController = sheetPresentationController{
            sheetPresentationController.detents = [.medium(), .large()]
            
        }
        
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        
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
    
    func requestNet(name: String){
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOGNiMmEwNTRjYTZmMTEyZDY2YjFlODE2ZTIzOWVlNiIsInN1YiI6IjY0OWJkOWUwNzdjMDFmMDBjYTVhNzkwZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YXEMCu81V6_te2LwVDZiNCFrn1GUZeCcTAj4WYTGwug"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=ko-KR&page=1&sort_by=popularity.desc&with_watch_providers=providers%3A8")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let API_KEY = "e8cb2a054ca6f112d66b1e816e239ee6"
        var movieSearchURL = URLComponents(string: "https://api.themoviedb.org/3/search/movie?")

        // 쿼리 아이템 정의
        let apiQuery = URLQueryItem(name: "api_key", value: API_KEY)
        let languageQuery = URLQueryItem(name: "language", value: "ko-KR")
        let searchQuery = URLQueryItem(name: "query", value: name)
        
        movieSearchURL?.queryItems?.append(apiQuery)
        movieSearchURL?.queryItems?.append(languageQuery)
        movieSearchURL?.queryItems?.append(searchQuery)
        
        guard let requestMovieSearchURL = movieSearchURL?.url else { return }
        
        let config = URLSessionConfiguration.default

        // session 설정
        let session = URLSession(configuration: config)

        let dataTask = session.dataTask(with: requestMovieSearchURL, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
              guard let resultData = data else { return }
              do{
                  let decoder = JSONDecoder()
                  let respons = try decoder.decode(Response.self, from: resultData)
                  let searchMovie = respons.result
                  
                  for i in searchMovie{
                      print("영화 제목 : \(i.title ?? "")")
                      print("영화 평점 : \(i.rating ?? 0)")
                      print("영화 줄거리 : \(i.summary ?? "")")
                      print("포스터 경로 : \(i.post ?? "")")
                      
                      print("--------------------------")
                  }
                  
              }catch let error{
                  print(error.localizedDescription)
              }
          }
        })

        dataTask.resume()
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
