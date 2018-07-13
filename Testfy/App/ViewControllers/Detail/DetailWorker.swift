//
//  DetailWorker.swift
//  Testfy
//
//  Created by Behran Kankul on 12.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

class DetailWorker
{
    func doSetup(_ viewController : DetailViewController) {
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
