//
//  TMDBAPI.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-25.
//

import Alamofire

struct TrendingMedia: Decodable {
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
    func trendingMedia(api: TMDBRequest, completionHandler: @escaping ([Result]) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header)
        .responseDecodable(of: TrendingMedia.self) { response in
                
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                completionHandler(value.results)
            case .failure(let error):
                print("FAILURE", error)
            }
        }
    }
    
    func trendingPeople(api: TMDBRequest, completionHandler: @escaping ([ResultPeople]) -> Void) {
            
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header)
        .responseDecodable(of: TrendingPeople.self) { response in
                
                switch response.result {
                case .success(let value):
                    print("SUCCESS")
                    completionHandler(value.results)
                case .failure(let error):
                    print("FAILURE", error)
                }
            }
    }
}
