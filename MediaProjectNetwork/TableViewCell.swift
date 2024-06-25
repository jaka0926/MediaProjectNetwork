//
//  TableViewCell.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-25.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static let id = "TableViewCell"
    lazy var categoryLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        view.text = "Sample Text"
        view.textColor = .white
        return view
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.backgroundColor = .black
        contentView.addSubview(categoryLabel)
        contentView.addSubview(collectionView)
        
        categoryLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(18)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
        collectionView.backgroundColor = .none
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


