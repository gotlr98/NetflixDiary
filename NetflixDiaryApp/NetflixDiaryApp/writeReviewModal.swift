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
import Kingfisher

protocol SendDataDelegate: AnyObject {
    func recieveData(title: String)
}

class writeReviewModal: UIViewController{
    
    var searchTextField: UITextField!
    var reviewField: UITextView!
    var delegate: SendDataDelegate?
    
    var img_url: [String] = []
    var select_title: String = ""
    var isButtonClicked: Bool = false
    var title_url: [String:String] = [:]
    var is_search: Bool = false
    
    var image = UIImageView()
    
    var titleLabel = UILabel()
    
    var searchButton: UIButton = .init(frame: .init())
    
    lazy var imageScrollView = UIScrollView()
    let imagePageControl = UIPageControl()
    let imageNumberLabel = UILabel()
    
    
    
    override func viewDidLoad() {
//        self.view.backgroundColor = .gray
        
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isDirectionalLockEnabled = true
        
        self.hideKeyboard()
        
        
        let contentView = UIView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        let registerBtn: UIButton = .init(frame: .init())
        
        
        registerBtn.backgroundColor = .orange
        
        registerBtn.setTitle("등록하기", for: .normal)
        registerBtn.addTarget(self, action: #selector(sendReview), for: .touchUpInside)
        
        contentView.addSubview(registerBtn)
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        registerBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        searchTextField = .init(frame: .init())
        
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "검색할 작품을 입력해주세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        searchTextField.font = UIFont.systemFont(ofSize: 20)
        searchTextField.borderStyle = .line
        searchTextField.autocorrectionType = .no
        searchTextField.keyboardType = .default
        searchTextField.textColor = .black
        searchTextField.returnKeyType = .done
        searchTextField.autocapitalizationType = .none
        
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        searchTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        let searchButton: UIButton = .init(frame: .init())
        
        
        searchButton.backgroundColor = .orange
        
//        searchButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
//        searchButton.addTarget(self, action: #selector(self.textFieldDidChanacge(_:)), for: .editingChanged)
        
        contentView.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        searchButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)


        if is_search{
            
            contentView.addSubview(image)
            image.translatesAutoresizingMaskIntoConstraints = false
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100).isActive = true
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            image.heightAnchor.constraint(equalToConstant: 200).isActive = true
            image.widthAnchor.constraint(equalToConstant: 200).isActive = true

            
            image.kf.setImage(
                with: URL(string: title_url[select_title]!),
                placeholder: nil
            )
            
            contentView.addSubview(titleLabel)
            
            titleLabel.text = self.select_title
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 40).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            
            reviewField = .init(frame: .init())
            
            reviewField.font = UIFont.systemFont(ofSize: 20)
            reviewField.autocorrectionType = .no
            reviewField.backgroundColor = .white
            reviewField.keyboardType = .default
            reviewField.returnKeyType = .done
            reviewField.textColor = .black
            reviewField.autocapitalizationType = .none
            reviewField.layer.borderWidth = 1.0
            reviewField.layer.borderColor = UIColor.red.cgColor
            
            contentView.addSubview(reviewField)
            reviewField.translatesAutoresizingMaskIntoConstraints = false
            reviewField.widthAnchor.constraint(equalToConstant: 300).isActive = true
            reviewField.heightAnchor.constraint(equalToConstant: 200).isActive = true
            
            reviewField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            reviewField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
        }

        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if let sheetPresentationController = sheetPresentationController{
            sheetPresentationController.detents = [.medium(), .large()]
            
        }
    }

    @objc func sendReview(){
        
        let review = User().get_user_net()
        
        var titles: [String] = []
        for i in review{
            titles.append(i.title)
        }
        
        if titles.contains(select_title){
            let error = UIAlertController(title: "Error", message: "이미 작성한 작품입니다.", preferredStyle: UIAlertController.Style.alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            error.addAction(defaultAction)
            
            self.present(error, animated: true)
            return
        }
        else{
            Netflix().set_net(title: select_title, url: title_url[select_title]!, review: reviewField.text)
            
            User().add_user_net(net: Netflix(title: select_title, img_url: title_url[select_title]!, review: reviewField.text))
            
    //        self.tabBarController?
            self.navigationController?.popViewController(animated: true)
        }
        
    }

    @objc func textFieldDidChanacge(_ sender: Any?) {
        self.img_url = []
    }
    
    @objc func search(){
        
        let alert = UIAlertController(title: "Error", message: "검색어를 입력해 주세요", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(defaultAction)
        
        self.title_url = [:]
        
        DispatchQueue.main.async {
            self.searchTextField.resignFirstResponder()
        }
        
        if let text = searchTextField.text, text.isEmpty{
            
            self.present(alert, animated: false)
            return
        }
        else{
            Task{
                await requestNet(name: self.searchTextField.text!)
                
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                let vc = searchMovie(a: self.title_url)
                vc.delegate = self
                vc.modalPresentationStyle = .automatic
                self.present(vc, animated: true)
    //            self.navigationController?.pushViewController(vc, animated: false)
            }
            
        }
        self.isButtonClicked = true
        
    }
    
    func requestNet(name: String) async {
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
    //                      print("영화 제목 : \(i.title ?? "")")
    //                      print("영화 평점 : \(i.rating ?? 0)")
    //                      print("영화 줄거리 : \(i.summary ?? "")")
    //                      print("포스터 경로 : \(i.post ?? "")")
    //
    //                      print("--------------------------")
                          self.title_url[i.title!] = "https://image.tmdb.org/t/p/w220_and_h330_face" + i.post!
                      }
                      
                  }catch let error{
                      print(error.localizedDescription)
                  }
              }
            })
            dataTask.resume()
        
    }

}

extension writeReviewModal{
    
    func hideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension writeReviewModal: SendDataDelegate {
    func recieveData(title: String) {
        
        view.subviews.forEach{ subview in
            subview.removeFromSuperview()
        }
        self.is_search = true
        self.select_title = title
        
        if (self.titleLabel.text != ""){
            self.titleLabel.text = ""
        }
        self.searchTextField.clearsOnBeginEditing = true
        self.searchTextField.text = ""
        
        
        self.viewDidLoad()
    }
}
