//
//  DetailPresenter.swift
//  Testfy
//
//  Created by Behran Kankul on 12.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

protocol DetailPresentationLogic
{
    func displayData(_ data:TweetModel)
}

class DetailPresenter: DetailPresentationLogic
{
    weak var viewController: DetailDisplayLogic?
    
    func displayData(_ data:TweetModel)
    {
        viewController?.setViewModel(data)
    }
}
