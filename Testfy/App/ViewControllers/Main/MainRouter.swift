//
//  MainRouter.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

protocol MainRoutingLogic
{
    func routeToDetail(data:TweetModel) 
}

protocol MainDataPassing
{
    var dataStore: MainDataStore? { get }
}

class MainRouter: NSObject, MainRoutingLogic, MainDataPassing
{
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
    
    //MARK : Routing
    func routeToDetail(data:TweetModel) {
        let detail = DetailViewController.fromStoryboard(.detail)
        var destination = detail.router!.dataStore!
        passDataToDetail(tweet: data,destination: &destination)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }
    private func passDataToDetail(tweet:TweetModel,destination: inout DetailDataStore)
    {
        destination.tweet = tweet
    }
}
