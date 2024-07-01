//
//  DetailViewController.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-30.
//

import UIKit
import SnapKit
import Kingfisher
import WebKit

class DetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let posterImage = UIImageView()
    let overView = UILabel()
    let airDate = UILabel()
    let rating = UIButton()
    let genres = UILabel()
    let videoView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(posterImage)
        contentView.addSubview(genres)
        contentView.addSubview(overView)
        contentView.addSubview(airDate)
        contentView.addSubview(rating)
        contentView.addSubview(videoView)
        
        configureLayout()
        
    }
    func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView) // Ensures content width matches scrollView's width
        }
        posterImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(posterImage.snp.width).multipliedBy(4.0/3.0)
        }
        rating.snp.makeConstraints { make in
            make.top.equalTo(posterImage).offset(10)
            make.right.equalTo(posterImage)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        airDate.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(posterImage)
        }
        genres.snp.makeConstraints { make in
            make.top.equalTo(airDate.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(posterImage)
        }
        overView.snp.makeConstraints { make in
            make.top.equalTo(genres.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(posterImage)
        }
        videoView.snp.makeConstraints { make in
            make.top.equalTo(overView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(posterImage)
            make.height.equalTo(300)
            make.bottom.equalTo(contentView).offset(-20)
        }
    }
    
    func configureUI(_ data: ResultSearch, _ videoKey: String) {
        
        posterImage.backgroundColor = .brown
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(data.poster_path ?? data.profile_path ?? "")")!
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        posterImage.kf.setImage(with: url)
        
        rating.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        rating.layer.cornerRadius = 20
        rating.layer.borderWidth = 1
        rating.layer.borderColor = UIColor.white.cgColor
        rating.backgroundColor = .black
        rating.tintColor = .white
        rating.setImage(UIImage(systemName: "star.fill"), for: .normal)
        rating.setTitle(data.vote_average?.formatted(.number.precision(.fractionLength(1))), for: .normal)
        rating.titleLabel?.textAlignment = .center
        
        airDate.text = "Aired: \(data.release_date ?? data.first_air_date ?? "")"
        airDate.textColor = .white
        
        genres.textColor = .white
        genres.font = .boldSystemFont(ofSize: 18)
        genres.numberOfLines = 0
        
        overView.text = data.overview
        overView.textColor = .white
        overView.numberOfLines = 0
        
        let videoURL = URL(string: "https://www.youtube.com/watch?v=\(videoKey)")
        let request = URLRequest(url: videoURL!)
        videoView.load(request)
        
    }
}
