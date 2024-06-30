//
//  _SearchTableViewCell.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-29.
//

import UIKit
import SnapKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    
    static let id = "SearchTableViewCell"
    let posterImage = UIImageView()
    let name = UILabel()
    let releaseDate = UILabel()
    var genreList = UILabel()
    let rating = UILabel()
    let mediaType = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        contentView.addSubview(posterImage)
        contentView.addSubview(name)
        contentView.addSubview(releaseDate)
        contentView.addSubview(genreList)
        contentView.addSubview(rating)
        contentView.addSubview(mediaType)
        
        configureLayout()
        
    }
    func configureLayout() {
        
        mediaType.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
        }
        posterImage.snp.makeConstraints { make in
            make.left.verticalEdges.equalToSuperview().inset(10)
            make.width.equalTo(100)
        }
        name.snp.makeConstraints { make in
            make.left.equalTo(posterImage.snp.right).offset(10)
            make.top.equalTo(mediaType.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        releaseDate.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(name)
            make.top.equalTo(name.snp.bottom).offset(10)
        }
        genreList.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(name)
            make.top.equalTo(releaseDate.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        rating.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(name)
            make.top.equalTo(genreList.snp.bottom).offset(10)
        }
    }
    
    func configureUI(_ data: ResultSearch) {
        
        posterImage.backgroundColor = .darkGray
        name.font = .monospacedDigitSystemFont(ofSize: 18, weight: .heavy)
        name.textColor = .white
        name.text = data.name ?? data.title
        
        releaseDate.font = .systemFont(ofSize: 14)
        releaseDate.textColor = .white
        let airDate = data.release_date ?? data.first_air_date ?? ""
        releaseDate.text = airDate
        
        genreList.textColor = .white
        
        rating.textColor = .systemTeal
        rating.font = .boldSystemFont(ofSize: 16)
        rating.text = (data.vote_average != nil) ? "Rating: \(data.vote_average!.formatted(.number.precision(.fractionLength(1)))) (\(data.vote_count!.formatted()) votes)" : ""
        
        mediaType.textColor = .white
        mediaType.text = data.media_type.rawValue
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(data.poster_path ?? data.profile_path ?? "")")!
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        posterImage.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
