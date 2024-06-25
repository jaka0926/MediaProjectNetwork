//
//  TMDBAPI.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-25.
//

import Alamofire

struct TrendingMovie: Decodable {
    let results: [Result]
}
struct Result: Decodable {
    let poster_path: String
}


struct TrendingPeople: Decodable {
    let results: [ResultPeople]
}
struct ResultPeople: Decodable {
    let profile_path: String
}

class TMDBAPI {
    
    static let shared = TMDBAPI()
    private init() { }
    
    //"poster_path"
    func trendingMovie(completionHandler: @escaping ([Result]) -> Void) {
        func callRequest() {
            
            let url = "https://api.themoviedb.org/3/trending/movie/day?language=ko-KR"
            let header: HTTPHeaders = ["Authorization": APIKey.TMDB]
            
            AF.request(url, method: .get, headers: header).responseDecodable(of: TrendingMovie.self) { response in
                
                switch response.result {
                case .success(let value):
                    print("SUCCESS")
                    completionHandler(value.results)
                case .failure(let error):
                    print("FAILURE", error)
                }
            }
        }
        callRequest()
    }
    func trendingTV(completionHandler: @escaping ([Result]) -> Void) {
        func callRequest() {
            
            let url = "https://api.themoviedb.org/3/trending/tv/day?language=ko-KR"
            let header: HTTPHeaders = ["Authorization": APIKey.TMDB]
            
            AF.request(url, method: .get, headers: header).responseDecodable(of: TrendingMovie.self) { response in
                
                switch response.result {
                case .success(let value):
                    print("SUCCESS")
                    completionHandler(value.results)
                case .failure(let error):
                    print("FAILURE", error)
                }
            }
        }
        callRequest()
    }
    func trendingPeople(completionHandler: @escaping ([ResultPeople]) -> Void) {
        func callRequest() {
            
            let url = "https://api.themoviedb.org/3/trending/person/day?language=en-US"
            let header: HTTPHeaders = ["Authorization": APIKey.TMDB]
            
            AF.request(url, method: .get, headers: header).responseDecodable(of: TrendingPeople.self) { response in
                
                switch response.result {
                case .success(let value):
                    print("SUCCESS")
                    completionHandler(value.results)
                case .failure(let error):
                    print("FAILURE", error)
                }
            }
        }
        callRequest()
    }
}

