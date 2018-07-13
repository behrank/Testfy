//
//  MainWorker.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit
import Moya
class MainWorker
{
    func doSetup(_ viewController : MainViewController) {
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    func getSearchFeed(req: Main.GetSearchFeed.Request,completion:@escaping (Main.FeedViewModel)->Void,failure:@escaping (String)->Void) {
        
        let getFeed:NetworkAPI = NetworkAPI.getSearchFeed(data:req)
        
        NetworkProvider.shared.call(target: getFeed, completion: { (res:Main.GetSearchFeed.Response) in
            
            debugPrint(res)
            completion(Main.FeedViewModel.init(tweets: res.statuses!))
            
        }) { (error) in
            failure(error)
        }
    }
    func getFeed(completion:@escaping (Main.FeedViewModel)->Void,failure:@escaping (String)->Void) {
        
        let getFeed:NetworkAPI = NetworkAPI.getFeed()

        NetworkProvider.shared.call(target: getFeed, completion: { (res:[TweetModel]) in
            
            debugPrint(res)
            completion(Main.FeedViewModel.init(tweets: res))
            
        }) { (error) in
            failure(error)
        }
    }
    
    func getMoreFeed(_ data:Main.GetMoreFeed.Request,completion:@escaping (Main.FeedViewModel)->Void,failure:@escaping (String)->Void) {
        
        let getFeed:NetworkAPI = NetworkAPI.getMoreFeed(data:data)
        debugPrint("Get More triggered")
        NetworkProvider.shared.call(target: getFeed, completion: { (res:[TweetModel]) in
            
            debugPrint(res)
            completion(Main.FeedViewModel.init(tweets: res))
            
        }) { (error) in
            failure(error)
        }
    }
    func getTokenFromTwitter(completion:@escaping ()->Void,failure:@escaping (String)->Void) {
    
        var request = URLRequest(url: URL(string: authUrl)!)
        request.httpMethod = "POST"
        request.addValue("Basic " + getBase64EncodeString(), forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField:"Content-Type")
        let grantType = "grant_type=client_credentials"
        request.httpBody = grantType.data(using: String.Encoding.utf8, allowLossyConversion:  true)
        
        let ss = URLSession.shared.dataTask(with: request) { (data, res, err) in
            do {
                if let results: NSDictionary = try JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments  ) as? NSDictionary {
                    if let token = results["access_token"] as? String {
                        UserData.accessToken.setToken(token: token)
                        completion()
                    } else {
                        failure(ErrorStrings.serverError.description())
                    }
                }
            } catch let error as NSError {
                debugPrint(error.localizedDescription)
                failure(ErrorStrings.serverError.description())
            }
        }
        ss.resume()
    }
    private func getBase64EncodeString() -> String {
        let consumerKeyRFC1738 = consumerKey.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let consumerSecretRFC1738 = consumerSecret.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let concatenateKeyAndSecret = consumerKeyRFC1738! + ":" + consumerSecretRFC1738!
        let secretAndKeyData = concatenateKeyAndSecret.data(using: String.Encoding.ascii, allowLossyConversion: true)
        let base64EncodeKeyAndSecret = secretAndKeyData?.base64EncodedString(options: NSData.Base64EncodingOptions())
        return base64EncodeKeyAndSecret!
    }
}
