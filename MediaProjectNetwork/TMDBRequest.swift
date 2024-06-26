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
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.TMDB]
    }
    
    var method: HTTPMethod {
        return .get
    }
}
