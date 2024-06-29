//
//  TMDBRequest.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-27.
//

import Foundation
import Alamofire

enum TMDBRequest {
    case trendingMovie
    case trendingTV
    case trendingPeople
    case searchMultiMedia
    case genreListTV
    case genreListMovie
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .trendingMovie:
            return URL(string: baseURL + "trending/movie/day")!
        case .trendingTV:
            return URL(string: baseURL + "trending/tv/day")!
        case .trendingPeople:
            return URL(string: baseURL + "trending/person/day")!
        case .searchMultiMedia:
            return URL(string: baseURL + "search/multi")!
        case .genreListTV:
            return URL(string: baseURL + "genre/tv/list")!
        case .genreListMovie:
            return URL(string: baseURL + "genre/movie/list")!
        }
        
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.TMDB]
    }
    
    var method: HTTPMethod {
        return .get
    }
}
