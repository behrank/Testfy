//
//  Common.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright © 2018 Be Moebil. All rights reserved.
//

import Foundation

let userAccessTokenKey = "useraccesstoken"
let consumerKey = "CNzYvD8Nc7bcCtMgWSSHgA"
let consumerSecret = "yKbcl5Dur4SQs0QepYjfPhl0yABSxZIoAXu04fbXFM"
let PAGE_SIZE_COUNT = 50
let DEFAULT_ACCOUNT = "nasa"
let authUrl = "https://api.twitter.com/oauth2/token"

let TWEETCELL = "TweetCell"
let TWEETCELL_REUSE = "TweetCellReuse"

enum UserData {
    case accessToken
    
    func get() -> String {
        return UserDefaults.standard.value(forKey: userAccessTokenKey) as! String
    }
    func setToken(token:String) {
        UserDefaults.standard.setValue(token, forKey: userAccessTokenKey)
        debugPrint("Token Set")
    }
}
enum ErrorStrings {
    case serverError
    
    func description() -> String {
        switch self {
        case .serverError:
            return "İşlem sırasında bir hata oluştu. Lütfen tekrar deneyin."
        default:
            return ""
        }
    }
}
enum Storyboard : String {
    
    //These are the Storyboard names
    case main = "Main"
    enum Identifier : String {
        
        //These are the ViewController Storyboard Identifiers
        case empty = ""
        case detail = "detailVC"
        
        //Storyboards owning viewcontrollers
        var storyboardName : Storyboard {
            switch self {
            case .detail:
                return .main
            default: return .main
            }
        }
    }
}
