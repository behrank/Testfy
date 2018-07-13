//
//  MainInteractor.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

protocol MainBusinessLogic
{
    func getToken()
    func getFeed()
    func getMoreFeed(_ req:Main.GetMoreFeed.Request)
    func getTweetsBySearch(_ req:Main.GetSearchFeed.Request)
}

protocol MainDataStore
{

}

class MainInteractor: MainBusinessLogic, MainDataStore
{
    var presenter: MainPresentationLogic?
    var worker = MainWorker()
    var isInfiniteTriggered = false

    func getToken() {
        self.presenter?.showLoading()
        worker.getTokenFromTwitter(completion: {
            self.getFeed()
        }, failure: { (errorDesc) in
            self.presenter?.showErrorWith(message: errorDesc)
        })
    }
    func getFeed(){
        self.presenter?.showLoading()
        worker.getFeed(completion: { (viewModel:Main.FeedViewModel) in
            self.presenter?.displayData(viewModel)
        }, failure: { (errorDesc) in
            self.presenter?.showErrorWith(message: errorDesc)
        })
    }
    func getMoreFeed(_ req:Main.GetMoreFeed.Request){
        
        if isInfiniteTriggered {
            return
        }
        isInfiniteTriggered = true
        worker.getMoreFeed(req, completion: { (viewModel:Main.FeedViewModel) in
            self.presenter?.displayMoreData(viewModel)
            self.isInfiniteTriggered = false

        }, failure: { (errorDesc) in
            self.isInfiniteTriggered = false
            self.presenter?.showErrorWith(message: errorDesc)
        })
    }
    func getTweetsBySearch(_ req:Main.GetSearchFeed.Request) {
         if isInfiniteTriggered {
            return
        }
        isInfiniteTriggered = req.sinceId! > 0
        worker.getSearchFeed(req: req, completion: { (viewModel:Main.FeedViewModel) in
            self.isInfiniteTriggered = false
            if req.sinceId! > 0 {
                self.presenter?.displayMoreData(viewModel)
            }
            else{
                self.presenter?.displayData(viewModel)
            }
            
        }, failure: { (errorDesc) in
            self.isInfiniteTriggered = false
            self.presenter?.showErrorWith(message: errorDesc)
        })
    }
}
