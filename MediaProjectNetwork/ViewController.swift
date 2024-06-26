//
//  ViewController.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-25.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        view.rowHeight = 220
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
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id) as! TableViewCell
        
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.id)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        cell.categoryLabel.text = categoryTitles[cell.collectionView.tag]
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id, for: indexPath) as! CollectionViewCell
        var url: URL
        
        switch collectionView.tag {
        case 2: let data = imageListPeople[indexPath.item]
                url = URL(string: "https://image.tmdb.org/t/p/w500\(data.profile_path)")!
        default: let data = imageList[collectionView.tag][indexPath.item]
                 url = URL(string: "https://image.tmdb.org/t/p/w500\(data.poster_path)")!
        }
        
        cell.posterImage.kf.setImage(with: url)
        return cell
    }
}
