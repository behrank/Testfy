//
//  MainPresenter.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

protocol MainPresentationLogic
{
    func showErrorWith(message:String)
    func displayData(_ data:Main.FeedViewModel)
    func displayMoreData(_ data:Main.FeedViewModel)
    func showLoading()
    func hideLoading()
}

class MainPresenter: MainPresentationLogic
{
    
    weak var viewController: MainDisplayLogic?

    func showErrorWith(message: String) {
        viewController?.removeLoading()
    }
    func displayData(_ data:Main.FeedViewModel) {
        viewController?.displayTweets(data)
        viewController?.removeLoading()
    }
    func displayMoreData(_ data: Main.FeedViewModel) {
        viewController?.displayMoreTweets(data)
    }
    func showLoading() {
        viewController?.displayLoading()
    }
    func hideLoading(){
        viewController?.removeLoading()
    }
}
