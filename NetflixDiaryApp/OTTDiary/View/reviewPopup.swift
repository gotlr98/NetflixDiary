//
//  reviewPopup.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/07/26.
//

import Foundation
import UIKit


class reviewPopup: UIViewController, UITextViewDelegate{
    
    let title_label = UILabel()
    let image = UIImageView()
    let editBtn: UIButton = .init(frame: .init())
    
    var movie_title: String
    var img_url: String
    var review: String
    
    var is_text_edit: Bool = false
    
    
    lazy var review_view: UITextView = {
        
        let text = UITextView()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.delegate = self
        
        return text
    }()
    
    init(movie_title: String, img_url: String, review: String){
        
        self.movie_title = movie_title
        self.img_url = img_url
        self.review = review
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init error occur")
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = .white
        
        self.hideKeyboard()
        
        
        setPopup()
        
    }
    
    @objc func edit(){
        
        if is_text_edit{
            
            print(is_text_edit)
            User().update_review(title: self.movie_title, review: self.review, change_review: review_view.text)
            
            dismiss(animated: true)
        }
        
        else{
            dismiss(animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DismissModal"), object: nil, userInfo: nil)
    }
    
    func setPopup(){
        self.view.addSubview(title_label)
        
        
        title_label.text = "' " + movie_title + " ' " + "리뷰: "
        title_label.translatesAutoresizingMaskIntoConstraints = false
        title_label.textColor = .black
        
        self.view.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        image.kf.setImage(
            with: URL(string: img_url),
            placeholder: nil
        )
        
        NSLayoutConstraint.activate([
            title_label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            title_label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            title_label.heightAnchor.constraint(equalToConstant: 100),
            title_label.widthAnchor.constraint(equalToConstant: 300)
        ])
        self.view.addSubview(review_view)
        
        review_view.text = self.review
        review_view.textColor = .black
        review_view.font = UIFont(name: "Callout", size: 50)
        review_view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            review_view.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            review_view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            review_view.widthAnchor.constraint(equalToConstant: 200),
            review_view.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        review_view.delegate = self
        
        review_view.textStorage.delegate = self
        
        editBtn.backgroundColor = .orange
        
        self.view.addSubview(editBtn)
        
        editBtn.setTitle("수정하기", for: .normal)
        
        editBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editBtn.widthAnchor.constraint(equalToConstant: 120),
            editBtn.heightAnchor.constraint(equalToConstant: 40),
            editBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            editBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    
        editBtn.addTarget(self, action: #selector(edit), for: .touchUpInside)
    }

}

extension reviewPopup{
    
    func hideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension reviewPopup: NSTextStorageDelegate {
    func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        is_text_edit = true
    }
}
