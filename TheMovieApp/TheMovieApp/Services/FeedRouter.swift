//
//  MoviesRouter.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 20/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation
import Moya

enum FeedRouter {
    case getMovieDetails(movieId: Int)
    case getPopularMovieList(page: Int)
    case searchMovies(query: String, page: Int)
}

extension FeedRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
   
    
    var path: String {
        switch self {
        case .getPopularMovieList:
            return "movie/popular"
        case .getMovieDetails(let id):
            return "movie/\(id)"
        case .searchMovies:
            return "search/movie"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return jsonSerializedUTF8(json: ["" : ""])
    }
    
    var task: Task {
        switch self {
        default:
            if let `parameters` = parameters {
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            } else {
                return .requestPlain
            }
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getMovieDetails:
            return ["api_key" : "432c9de63acf48d4822a16019607fd34",
                    "append_to_response" : "credits"]
        case .getPopularMovieList(let page):
            return ["api_key": "432c9de63acf48d4822a16019607fd34",
                    "language": "en-US",
                    "page": page]
        case .searchMovies(let query, let page):
            let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            return ["api_key": "432c9de63acf48d4822a16019607fd34",
                    "language": "en-US",
                    "query": safeQuery,
                    "page": page]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

func jsonSerializedUTF8(json: [String: Any]) -> Data {
    do {
        return try JSONSerialization.data(
            withJSONObject: json,
            options: [.prettyPrinted]
        )
    } catch {
        return Data()
    }
}


