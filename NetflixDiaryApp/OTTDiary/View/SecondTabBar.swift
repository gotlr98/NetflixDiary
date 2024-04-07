//
//  SecondTabBar.swift
//  NetflixDiaryApp
//
//  Created by HaeSik Jang on 2023/06/29.
//

import Foundation
import UIKit

class SecondTabBar: UIViewController{
    var movie = [[String]]()
    
    var tv = [[String]]()
    
    let title1 = UILabel()
    let title2 = UILabel()
    let scrollView = UIScrollView()
    let contentView = UIView()

    lazy var popularMovie: UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        
        lay.minimumLineSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: lay)
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var popularTV: UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        
        lay.minimumLineSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: lay)
        view.backgroundColor = .white
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScroll()
        
        setTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가하기", image: UIImage(systemName: "magnifyingglass"), target: nil, action: nil)

        self.navigationItem.rightBarButtonItem!.menu = UIMenu(children: [
                        UIAction(title: "리뷰쓰기", attributes: .destructive, handler: { _ in
                            self.navigationController?.pushViewController(writeReviewModal(), animated: true)
                        })
                    ])
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setScroll(){
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isDirectionalLockEnabled = true
                
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
        
        contentView.addSubview(popularMovie)
        
        contentView.addSubview(popularTV)
        
        popularMovie.delegate = self
        
        popularMovie.dataSource = self
        
        popularMovie.register(popularMovieCell.self, forCellWithReuseIdentifier: popularMovieCell.id)
        
        popularMovie.translatesAutoresizingMaskIntoConstraints = false
        popularMovie.isPagingEnabled = true

        NSLayoutConstraint.activate([
            popularMovie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            popularMovie.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 90),
            popularMovie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            popularMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            popularMovie.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        popularTV.delegate = self
        
        popularTV.dataSource = self
        
        popularTV.register(popularMovieCell.self, forCellWithReuseIdentifier: popularMovieCell.id)
        
        popularTV.translatesAutoresizingMaskIntoConstraints = false
        popularTV.isPagingEnabled = true
        
        NSLayoutConstraint.activate([
            popularTV.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            popularTV.topAnchor.constraint(equalTo: self.popularMovie.bottomAnchor, constant: 100),
            popularTV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            popularTV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            popularTV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            popularTV.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func setTitle(){
        
        contentView.addSubview(title1)
        contentView.addSubview(title2)
        
        title1.translatesAutoresizingMaskIntoConstraints = false
        title2.translatesAutoresizingMaskIntoConstraints = false
        
        title1.text = " 오늘의 Top 10 영화"
        title2.text = " 오늘의 Top 10 TV시리즈"
        title1.font = UIFont.italicSystemFont(ofSize: 20)
        title2.font = UIFont.italicSystemFont(ofSize: 20)
        title1.sizeToFit()
        title2.sizeToFit()
        
        title1.textColor = .black
        title2.textColor = .black
        
        NSLayoutConstraint.activate([
            title1.bottomAnchor.constraint(equalTo: popularMovie.topAnchor, constant: -30),
            title1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            title2.topAnchor.constraint(equalTo: popularMovie.bottomAnchor, constant: 30),
            title2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
}


extension SecondTabBar: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Movie와 TV를 따로 보여주는 collectionview 처리
        if collectionView == self.popularMovie{
            return movie.count
        }
        
        else{
            return tv.count
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.popularMovie{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularMovieCell.id, for: indexPath)
            if let cell = cell as? popularMovieCell {
                cell.name.text = "제목: " + movie[indexPath.item][0]
                cell.name.textColor = .black
                cell.rating.text = "평점: " + movie[indexPath.item][1]
                cell.rating.textColor = .black
                
                // 줄거리가 비었을때 처리
                if movie[indexPath.item][2].isEmpty{
                    cell.comment.text = "줄거리가 비었습니다"
                }
                else{
                    cell.comment.text = "줄거리: " + movie[indexPath.item][2]
                    cell.comment.textColor = .black

                }
                cell.image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w220_and_h330_face" + movie[indexPath.item][3]))
            }
            return cell
        }
        
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularMovieCell.id2, for: indexPath)
            if let cell = cell as? popularMovieCell {
                cell.name.text = "제목: " + tv[indexPath.item][0]
                cell.rating.text = "평점: " + tv[indexPath.item][1]
                cell.name.textColor = .black
                cell.rating.textColor = .black
                if tv[indexPath.item][2].isEmpty{
                    cell.comment.text = "줄거리가 비었습니다"
                }
                else{
                    cell.comment.text = "줄거리: " + tv[indexPath.item][2]
                    cell.comment.textColor = .black

                }
                cell.image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w220_and_h330_face" + tv[indexPath.item][3]))
            }
            return cell
        }
    }
}

extension SecondTabBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height) // point
    }
}

