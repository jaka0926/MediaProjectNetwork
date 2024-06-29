//
//  SearchViewController.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-28.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

    let searchField = UISearchTextField()
    let tableView = UITableView()
    var list: [ResultSearch] = []
    var GenreList: [GenreResult] = []
    var GenreListCleaned: [GenreResult] = []
    var count = [1, 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SEARCH"
        view.backgroundColor = .black
        view.addSubview(searchField)
        view.addSubview(tableView)
        
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPI.shared.genreList(api: TMDBRequest.genreListTV) { data in
            DispatchQueue.main.async {
                self.GenreList = data
                print("SEARCH=====1")
                group.leave()
            }
        }
        group.enter()
        TMDBAPI.shared.genreList(api: TMDBRequest.genreListMovie) { data in
            DispatchQueue.main.async {
                self.GenreList.append(contentsOf: data)
                print("SEARCH=====2")
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.GenreListCleaned = Array(Set(self.GenreList))
            print("SEARCH=====3")
            print(self.GenreList.count)
            print(self.GenreListCleaned.count)
            dump(self.GenreListCleaned)
            print(self.GenreListCleaned[0])
        }
        
        
        configureLayoutAndUI()
        searchField.addTarget(self, action: #selector(searchButtonClicked), for: .editingDidEndOnExit)
    }
    
    func configureLayoutAndUI() {
        
        searchField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchField.textColor = .white
        searchField.placeholder = "Titles, people"
        searchField.keyboardAppearance = .dark
        searchField.returnKeyType = .search
        searchField.enablesReturnKeyAutomatically = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        tableView.backgroundColor = .none
        tableView.rowHeight = 150
    }
    
    @objc func searchButtonClicked() {
        print(#function)
        TMDBAPI.shared.searchMultiMedia(api: TMDBRequest.searchMultiMedia, query: searchField.text!) { data in
            self.list = data
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        dump(GenreList)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id) as! SearchTableViewCell
        let data = list[indexPath.row]
        
        cell.genreList.text = ""
        
        let genreIds = data.genre_ids
        if genreIds == nil {
            cell.configureUI(data)
            return cell
        }
        var genreNames: [String] = []
        for id in genreIds! {
            for num in GenreListCleaned {
                if id == num.id {
                    genreNames.append(num.name)
                }
            }
        }
        cell.genreList.text = genreNames.joined(separator: ", ")
        cell.configureUI(data)
        return cell
    }
    
    
}
