//
//  DetailRouter.swift
//  Testfy
//
//  Created by Behran Kankul on 12.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

@objc protocol DetailRoutingLogic
{

}

protocol DetailDataPassing
{
    var dataStore: DetailDataStore? { get set}
}

class DetailRouter: NSObject, DetailRoutingLogic, DetailDataPassing
{
    weak var viewController: DetailViewController?
    var dataStore: DetailDataStore?
    
    //MARK : Routing
    
}
