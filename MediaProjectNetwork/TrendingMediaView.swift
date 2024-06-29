//
//  TrendingMediaView.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-25.
//

import UIKit
import SnapKit
import Kingfisher

class TrendingMediaView: UIViewController {
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.id)
        return view
    }()
    let categoryTitles = ["Movies", "Series", "People"]
    var imageList: [[Result]] = [[Result(poster_path: "")],
                                 [Result(poster_path: "")]
                                ]
    var imageListPeople: [ResultPeople] = [ResultPeople(profile_path: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TRENDING"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        
        view.backgroundColor = .black
        view.addSubview(tableView)
        tableView.backgroundColor = .none
        configureLayout()
        let group = DispatchGroup()
        
        //CallRequest - TredingMovie
        group.enter()
        DispatchQueue.main.async {
            TMDBAPI.shared.trendingMedia(api: TMDBRequest.trendingMovie) { data in
                self.imageList[0] = data
                print("=====111111")
                group.leave()
            }
        }
        //CallRequest - TredingTV
        group.enter()
        DispatchQueue.main.async {
            TMDBAPI.shared.trendingMedia(api: TMDBRequest.trendingTV) { data in
                self.imageList[1] = data
                print("=====222222")
                group.leave()
            }
        }
        //CallRequest - TrendingPeople
        group.enter()
        DispatchQueue.main.async {
            TMDBAPI.shared.trendingPeople(api: TMDBRequest.trendingPeople) { data in
                self.imageListPeople = data
                print("=====333333")
                group.leave()
            }
        }
        group.notify(queue: .main) {
            print("=====444444")
            self.tableView.reloadData()
        }

    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func rightBarButtonClicked() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

extension TrendingMediaView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.id) as! TrendingTableViewCell
        
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.id)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        cell.categoryLabel.text = categoryTitles[cell.collectionView.tag]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 260
        }
        return 220
    }
}

extension TrendingMediaView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("imageList0: ", imageList[0].count)
//        print("imageList1: ", imageList[1].count)
//        print("imageListPeople: ",imageListPeople.count)
        return imageList[1].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.id, for: indexPath) as! TrendingCollectionViewCell
        var url: URL
        
        switch collectionView.tag {
        case 2: let data = imageListPeople[indexPath.item]
            if data.profile_path == nil {
                cell.posterImage.image = UIImage(systemName: "questionmark.square")
                cell.posterImage.tintColor = .white
                cell.posterImage.contentMode = .scaleAspectFit
                return cell }
            url = URL(string: "https://image.tmdb.org/t/p/w500\(data.profile_path!)")!
        default: let data = imageList[collectionView.tag][indexPath.item]
                 url = URL(string: "https://image.tmdb.org/t/p/w500\(data.poster_path!)")!
        }
        cell.posterImage.contentMode = .scaleAspectFill
        cell.posterImage.kf.setImage(with: url)
        return cell
    }
}
