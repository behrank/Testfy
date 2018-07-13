//
//  DetailInteractor.swift
//  Testfy
//
//  Created by Behran Kankul on 12.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

protocol DetailBusinessLogic
{
    func updateUIWithTweet()
}

protocol DetailDataStore
{
    var tweet:TweetModel? {get set}
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore
{
    var tweet: TweetModel?
    
    var presenter: DetailPresentationLogic?
    var worker: DetailWorker?
    
    func updateUIWithTweet() {
        self.presenter?.displayData(tweet!)
    }
}
