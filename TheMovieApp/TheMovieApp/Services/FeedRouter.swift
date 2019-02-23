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
}

extension FeedRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie")!
    }
   
    
    var path: String {
        switch self {
        case .getPopularMovieList:
            return "/popular"
        case .getMovieDetails(let id):
            return "/\(id)"
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
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default) //URLEncoding.default
            } else {
                return .requestPlain
            }
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getMovieDetails:
            return ["api_key" : "432c9de63acf48d4822a16019607fd34",
                    "append_to_response" : "credits,reviews"]
        case .getPopularMovieList(let page):
            return ["api_key": "432c9de63acf48d4822a16019607fd34",
                    "language": "en-US",
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


