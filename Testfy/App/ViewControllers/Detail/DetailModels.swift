//
//  DetailModels.swift
//  Testfy
//
//  Created by Behran Kankul on 12.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

enum Detail
{
    struct ViewModel {
        var data:TweetModel?
        
        init(tweet:TweetModel) {
            self.data = tweet
        }
    }
}
