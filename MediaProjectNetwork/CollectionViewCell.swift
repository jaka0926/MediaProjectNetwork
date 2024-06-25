//
//  CollectionViewCell.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-25.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    static let id = "CollectionViewCell"
    let posterImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        posterImage.backgroundColor = .brown
        posterImage.layer.cornerRadius = 10
        posterImage.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
