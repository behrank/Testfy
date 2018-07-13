//
//  TweetCell.swift
//  Testfy
//
//  Created by Behran Kankul on 12.07.2018.
//  Copyright © 2018 Be Moebil. All rights reserved.
//

import UIKit

class TweetCell:UITableViewCell {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var txtTweet: UITextView!
    
    var viewModel:TweetModel? {
        didSet {
            lblUsername.text = viewModel?.user?.screenName
            lblTime.text = viewModel?.createdAt ?? ""
            txtTweet.text = viewModel?.text ?? ""
        }
    }
    var imgUrl:String? {
        didSet {
            imgUser.loadImageUsingUrlString(urlString: imgUrl!)
        }
    }
}
