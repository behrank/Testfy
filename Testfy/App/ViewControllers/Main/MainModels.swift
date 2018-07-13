//
//  MainModels.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

enum Main
{
    // MARK: Use cases
    enum GetFeed {
        
        struct Request {
            //İlk gönderim için bir değer gerekmiyor. Arayüzden tweet sayısı filtrelenmesi gibi use case'lerde buraya parametre gelebilir.
        }
        struct Response {
            //data harici diğer propertyler için işlem (verileri kaydetmek gibi) yapılabilir. Bu örnekte gerek görmedim.
        }
    }
    enum GetMoreFeed {
        
        struct Request {
            var sinceId:Int
            init(sinceTweetId:Int) {
                self.sinceId = sinceTweetId
            }
        }
        struct Response {
            //data harici diğer propertyler için işlem (verileri kaydetmek gibi) yapılabilir. Bu örnekte gerek görmedim.
        }
    }
    enum GetSearchFeed {
        
        struct Request {
            var query:String
            var sinceId:Int?
            init(text:String) {
                self.sinceId = 0
                self.query = text
            }
            init(text:String,sinceTweetId:Int) {
                self.sinceId = sinceTweetId
                self.query = text
            }
        }
        struct Response:Decodable {
            var statuses:[TweetModel]?
            //data harici diğer propertyler için işlem (verileri kaydetmek gibi) yapılabilir. Bu örnekte gerek görmedim.
        }
    }
    struct FeedViewModel {
        var data:[TweetModel]?
        init(tweets:[TweetModel]){
            self.data = tweets
        }
    }
}
