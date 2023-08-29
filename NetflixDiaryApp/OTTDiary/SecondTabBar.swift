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
        
        lay.minimumLineSpacing = 50
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: lay)
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var popularTV: UICollectionView = {
       
        
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        
        lay.minimumLineSpacing = 50
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: lay)
        view.backgroundColor = .white
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let refresh = UIRefreshControl()
//
//        refresh.addTarget(self, action: #selector(getData), for: .valueChanged)
//
//        self.popularMovie.refreshControl = refresh
        
        
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
    
    @objc func getData(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.findPopular(kind: "movie")
//            self.popularMovie.refreshControl?.endRefreshing()
            
        }
        
        
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
        
        popularMovie.layer.borderColor = UIColor.orange.cgColor
        popularTV.layer.borderColor = UIColor.orange.cgColor
        
        popularMovie.layer.borderWidth = 3
        popularTV.layer.borderWidth = 3

        
        popularMovie.delegate = self
        
        popularMovie.dataSource = self
        
        popularMovie.register(popularMovieCell.self, forCellWithReuseIdentifier: popularMovieCell.id)
        
        popularMovie.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        title1.text = " 인기있는 영화"
        title2.text = " 인기있는 TV시리즈"
        
        title1.backgroundColor = .lightGray
        title2.backgroundColor = .lightGray
        
        title1.textColor = .white
        title2.textColor = .white
        
        
        title1.layer.borderColor = UIColor.lightGray.cgColor
        title2.layer.borderColor = UIColor.lightGray.cgColor
        
        title1.layer.borderWidth = 3
        title2.layer.borderWidth = 3
        
        title1.layer.cornerRadius = 3
        title2.layer.cornerRadius = 3
        
        NSLayoutConstraint.activate([
            title1.bottomAnchor.constraint(equalTo: popularMovie.topAnchor, constant: -30),
            title1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            title1.widthAnchor.constraint(equalToConstant: 200),
            title1.heightAnchor.constraint(equalToConstant: 25),
            
            title2.topAnchor.constraint(equalTo: popularMovie.bottomAnchor, constant: 20),
            title2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            title2.widthAnchor.constraint(equalToConstant: 200),
            title2.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
    }
    
}


extension SecondTabBar: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
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
                cell.rating.text = "평점: " + movie[indexPath.item][1]
                if movie[indexPath.item][2].isEmpty{
                    cell.comment.text = "줄거리가 비었습니다"
                }
                else{
                    cell.comment.text = "줄거리: " + movie[indexPath.item][2]

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
                if tv[indexPath.item][2].isEmpty{
                    cell.comment.text = "줄거리가 비었습니다"
                }
                else{
                    cell.comment.text = "줄거리: " + tv[indexPath.item][2]

                }
                cell.image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w220_and_h330_face" + tv[indexPath.item][3]))
            }

            return cell
        }
        
        
    }
}

extension SecondTabBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: collectionView.frame.height) // point
    }
}


//extension UIScrollView {
//    func updateContentSize() {
//        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
//        
//        // 계산된 크기로 컨텐츠 사이즈 설정
//        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height+50)
//    }
//    
//    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
//        var totalRect: CGRect = .zero
//        
//        // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
//        for subView in view.subviews {
//            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
//        }
//        
//        // 최종 계산 영역의 크기를 반환
//        return totalRect.union(view.frame)
//    }
//}
