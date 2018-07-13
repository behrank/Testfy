//
//  File.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright © 2018 Be Moebil. All rights reserved.
//

import Foundation

struct TweetModel:Decodable {
    var createdAt: String?
    var user: User?
    var source: String?
    var isQuoteStatus: Bool? = false
    var lang: String?
    var favoriteCount: Int?
    var retweetCount: Int?
    var favorited: Bool? = false
    var id: Int?
    var retweeted: Bool? = false
    var possiblySensitive: Bool? = false
    var text: String?
    var idStr: String?
    var truncated: Bool? = false
    var entities: Entities?
    
    private enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case user = "user"
        case source = "source"
        case isQuoteStatus = "is_quote_status"
        case lang = "lang"
        case favoriteCount = "favorite_count"
        case retweetCount = "retweet_count"
        case favorited = "favorited"
        case id = "id"
        case retweeted = "retweeted"
        case possiblySensitive = "possibly_sensitive"
        case text = "text"
        case idStr = "id_str"
        case truncated = "truncated"
        case entities = "entities"
    }
}

struct User:Decodable {
     var translatorType: String?
     var protected: Bool? = false
     var profileSidebarBorderColor: String?
     var profileLinkColor: String?
     var lang: String?
     var favouritesCount: Int?
     var defaultProfileImage: Bool? = false
     var profileBackgroundColor: String?
     var profileSidebarFillColor: String?
     var profileBackgroundTile: Bool? = false
     var isTranslator: Bool? = false
     var isTranslationEnabled: Bool? = false
     var profileImageUrlHttps: String?
     var friendsCount: Int?
     var id: Int?
     var entities: Entities?
     var profileBackgroundImageUrlHttps: String?
     var profileImageUrl: String?
     var statusesCount: Int?
     var defaultProfile: Bool? = false
     var url: String?
     var listedCount: Int?
     var name: String?
     var geoEnabled: Bool? = false
     var profileUseBackgroundImage: Bool? = false
     var screenName: String?
     var descriptionValue: String?
     var contributorsEnabled: Bool? = false
     var hasExtendedProfile: Bool? = false
     var followersCount: Int?
     var verified: Bool? = false
     var location: String?
     var createdAt: String?
     var idStr: String?
     var profileBannerUrl: String?
     var profileBackgroundImageUrl: String?
     var profileTextColor: String?
    
    private enum CodingKeys: String, CodingKey {
        case translatorType = "translator_type"
        case protected = "protected"
        case profileSidebarBorderColor = "profile_sidebar_border_color"
        case profileLinkColor = "profile_link_color"
        case lang = "lang"
        case favouritesCount = "favourites_count"
        case defaultProfileImage = "default_profile_image"
        case profileBackgroundColor = "profile_background_color"
        case profileSidebarFillColor = "profile_sidebar_fill_color"
        case profileBackgroundTile = "profile_background_tile"
        case isTranslator = "is_translator"
        case isTranslationEnabled = "is_translation_enabled"
        case profileImageUrlHttps = "profile_image_url_https"
        case friendsCount = "friends_count"
        case id = "id"
        case entities = "entities"
        case profileBackgroundImageUrlHttps = "profile_background_image_url_https"
        case profileImageUrl = "profile_image_url"
        case statusesCount = "statuses_count"
        case defaultProfile = "default_profile"
        case url = "url"
        case listedCount = "listed_count"
        case name = "name"
        case geoEnabled = "geo_enabled"
        case profileUseBackgroundImage = "profile_use_background_image"
        case screenName = "screen_name"
        case descriptionValue = "description"
        case contributorsEnabled = "contributors_enabled"
        case hasExtendedProfile = "has_extended_profile"
        case followersCount = "followers_count"
        case verified = "verified"
        case location = "location"
        case createdAt = "created_at"
        case idStr = "id_str"
        case profileBannerUrl = "profile_banner_url"
        case profileBackgroundImageUrl = "profile_background_image_url"
        case profileTextColor = "profile_text_color"
    }
}
struct Entities:Decodable {
    
    var urls: [Urls]?
    
    private enum CodingKeys:String,CodingKey {
        case urls = "urls"
    }
}
struct Urls: Decodable {

    public var displayUrl: String?
    public var indices: [Int]?
    public var expandedUrl: String?
    public var url: String?
    
    private enum CodingKeys:String,CodingKey {
        case displayUrl = "display_url"
        case indices = "indices"
        case expandedUrl = "expanded_url"
        case url = "url"
    }
}
