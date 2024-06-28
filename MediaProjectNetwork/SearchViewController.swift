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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        view.backgroundColor = .black
        view.addSubview(searchField)
        
        searchField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        searchField.textColor = .white
        searchField.placeholder = "Search by title"
        searchField.keyboardAppearance = .dark
        searchField.returnKeyType = .search
        searchField.enablesReturnKeyAutomatically = true
    }
}
