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

protocol SendDataDelegate: AnyObject {
    func recieveData(title: String)
}


class writeReviewModal: UIViewController{
    
    var searchTextField: UITextField!
    var delegate: SendDataDelegate?
    var img_url: [String] = []
    var select_title: String = ""
    var isButtonClicked: Bool = false
    var title_url: [String:String] = [:]
    
    var searchButton: UIButton = .init(frame: .init())
    
    lazy var imageScrollView = UIScrollView()
    let imagePageControl = UIPageControl()
    let imageNumberLabel = UILabel()
    
    
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
        
        let searchButton: UIButton = .init(frame: .init())
        
        
        searchButton.backgroundColor = .orange
        
//        searchButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
//        searchButton.addTarget(self, action: #selector(self.textFieldDidChanacge(_:)), for: .editingChanged)
        
        self.view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        searchButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        
//        self.view.addSubview(imageScrollView)
//        self.view.addSubview(imagePageControl)
//        self.view.addSubview(imageNumberLabel)
//
//        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
//        imageScrollView.isPagingEnabled = true
//        imageScrollView.showsHorizontalScrollIndicator = false
//        imageScrollView.delegate = self
//
//
//        imagePageControl.translatesAutoresizingMaskIntoConstraints = false
//        imagePageControl.currentPage = 0
//        imagePageControl.pageIndicatorTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
//        imagePageControl.currentPageIndicatorTintColor = .white
//        imagePageControl.hidesForSinglePage = true
//
//
//        imageNumberLabel.translatesAutoresizingMaskIntoConstraints = false
//        imageNumberLabel.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.5)
//        imageNumberLabel.layer.cornerRadius = 14
//        imageNumberLabel.clipsToBounds = true
//        imageNumberLabel.text = "0/1"
//        imageNumberLabel.font = .systemFont(ofSize: 12, weight: .semibold)
//        imageNumberLabel.textColor = .white
//
//
//        img_url.append("https://image.tmdb.org/t/p/w220_and_h330_face/9WF6TxCYwdiZw51NM92ConaQz1w.jpg")
//        img_url.append("https://image.tmdb.org/t/p/w220_and_h330_face/9WF6TxCYwdiZw51NM92ConaQz1w.jpg")
//        img_url.append("https://image.tmdb.org/t/p/w220_and_h330_face/9WF6TxCYwdiZw51NM92ConaQz1w.jpg")
//        img_url.append("https://image.tmdb.org/t/p/w220_and_h330_face/9WF6TxCYwdiZw51NM92ConaQz1w.jpg")
//
//        setImageSlider(images: img_url)
        
        
//        let slide = ImageSlideshow()
//
//        lazy var labelView: UIView = {
//            let view = UIView()
//            view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
//            return view
//        }()
//
//        slide.contentScaleMode = .scaleAspectFit
//        slide.pageIndicatorPosition = .init(horizontal: .right(padding: 20), vertical: .customBottom(padding: 20))
//
//        let labelIndicator = LabelPageIndicator()
//        labelIndicator.textColor = .white
//        labelIndicator.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//
//        slide.addSubview(labelView)
//        self.view.addSubview(slide)
//
//        slide.translatesAutoresizingMaskIntoConstraints = false
//        slide.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        slide.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        slide.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
//        slide.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//
//        slide.activityIndicator = DefaultActivityIndicator(style: .medium, color: .white)
        

        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if let sheetPresentationController = sheetPresentationController{
            sheetPresentationController.detents = [.medium(), .large()]
            
        }
        
    }

    @objc func cancel(){
        print(self.select_title)
    }

    @objc func textFieldDidChanacge(_ sender: Any?) {
        self.img_url = []
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
//    func setImageSlider(images: [String]) { // scrolliVew에 imageView 추가하는 함수
//        for index in 0..<images.count {
//
//            let url = URL(string: images[index])
//            var image: UIImage?
//
//            DispatchQueue.global().async{
//                let data = try? Data(contentsOf: url!)
//                    DispatchQueue.main.async {
//                        image = UIImage(data: data!)
//                    }
//            }
//
//            let imageView = UIImageView()
//            imageView.image = image
//            imageView.contentMode = .scaleAspectFit
//            imageView.layer.cornerRadius = 5
//            imageView.clipsToBounds = true
//
//            let xPosition = self.view.frame.width * CGFloat(index)
//
//            imageView.frame = CGRect(x: xPosition,
//                                   y: 0,
//                                   width: self.view.frame.width,
//                                   height: self.view.frame.width)
//
//            imageScrollView.contentSize.width = self.view.frame.width * CGFloat(index+1)
//            imageScrollView.addSubview(imageView)
//        }
//      }

}

extension writeReviewModal: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) { // scrollView가 스와이프 될 때 발생 될 이벤트
    self.imagePageControl.currentPage = Int(round(imageScrollView.contentOffset.x / UIScreen.main.bounds.width))
    self.imageNumberLabel.text = "\(imagePageControl.currentPage)/\(imagePageControl.numberOfPages)"
  }
}


extension writeReviewModal: SendDataDelegate {
    func recieveData(title: String) {
        self.select_title = title
    }
}
