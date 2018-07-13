//
//  NetworkAPI.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright © 2018 Be Moebil. All rights reserved.
//


import Foundation
import Moya

enum NetworkAPI {
    case getFeed()
    case getMoreFeed(data:Main.GetMoreFeed.Request)
    case getSearchFeed(data:Main.GetSearchFeed.Request)
}
// MARK: - TargetType Protocol Implementation
extension NetworkAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .getFeed(), .getMoreFeed(_),.getSearchFeed(_):
            return URL(string: "https://api.twitter.com/")!
        }
    }
    
    var path: String {
        switch self {
            case .getFeed(), .getMoreFeed(_):
                return "/1.1/statuses/user_timeline.json"
            case .getSearchFeed(_):
                return "/1.1/search/tweets.json"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getFeed(), .getMoreFeed(_),.getSearchFeed(_):
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getFeed:
            return .requestParameters(parameters: ["count":PAGE_SIZE_COUNT,"screen_name":DEFAULT_ACCOUNT], encoding: URLEncoding.queryString)
        case .getMoreFeed(let data):
            return .requestParameters(parameters: ["count":PAGE_SIZE_COUNT,"screen_name":DEFAULT_ACCOUNT,"sinceId":data.sinceId], encoding: URLEncoding.queryString)
        case .getSearchFeed(let data):
            return .requestParameters(parameters: ["q":data.query,"count":PAGE_SIZE_COUNT,"screen_name":DEFAULT_ACCOUNT,"sinceId":data.sinceId ?? 0], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .getFeed(), .getMoreFeed(_), .getSearchFeed(_):
            return ["Authorization" : "Bearer \(UserData.accessToken.get())"]
        }
        
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
