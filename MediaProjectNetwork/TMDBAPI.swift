//
//  TMDBAPI.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-25.
//

import Alamofire

// MARK: - TrendingMedia
struct TrendingMedia: Decodable {
    let results: [Result]
}
struct Result: Decodable {
    let poster_path: String?
}

// MARK: - TrendingPeople
struct TrendingPeople: Decodable {
    let results: [ResultPeople]
}
struct ResultPeople: Decodable {
    let profile_path: String?
}

// MARK: - SearchMultiMedia
struct SearchMultiMedia: Decodable {
    let results: [ResultSearch]
}

struct ResultSearch: Decodable {
    let id: Int
    let name: String?
    let title: String?
    let overview: String?
    let release_date, first_air_date: String?
    let genre_ids: [Int]?
    let vote_average: Double?
    let vote_count: Int?
    let media_type: MediaType
    let poster_path, profile_path: String?
}
enum MediaType: String, Decodable {
    case movie
    case person
    case tv
}

// MARK: - GenreList
struct GenreList: Decodable {
    let genres: [ResultGenre]
}

struct ResultGenre: Decodable, Hashable {
    let id: Int
    let name: String
}

// MARK: - Videos
struct Videos: Decodable {
    let id: Int
    let results: [ResultVideo]
}
struct ResultVideo: Decodable {
    let name, key: String
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
                print("FAILURE")
                dump(error)
            }
        }
    }
    
    func searchMultiMedia(api: TMDBRequest, query: String, completionHandler: @escaping ([ResultSearch]) -> Void) {
        
        let url = "\(api.endpoint)?query=\(query)"
        AF.request(url,
                   method: api.method,
                   headers: api.header)
        .responseDecodable(of: SearchMultiMedia.self) { response in
                
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                completionHandler(value.results)
            case .failure(let error):
                print("FAILURE", error)
            }
        }
    }
    
    func genreList(api: TMDBRequest, completionHandler: @escaping ([ResultGenre]) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header)
        .responseDecodable(of: GenreList.self) { response in
                
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                completionHandler(value.genres)
            case .failure(let error):
                print("FAILURE", error)
            }
        }
    }
    
    func youtubeVideo(api: TMDBRequest, mediaType: String, mediaId: Int, completionHandler: @escaping ([ResultVideo]) -> Void) {
        
        let url = "https://api.themoviedb.org/3/\(mediaType)/\(mediaId)/videos"
        AF.request(url,
                   method: api.method,
                   headers: api.header)
        .responseDecodable(of: Videos.self) { response in
                
            switch response.result {
            case .success(let value):
                print("SUCCESS ==== VIDEO API")
                completionHandler(value.results)
            case .failure(let error):
                print("FAILURE ==== VIDEO API", error)
            }
        }
    }
}
