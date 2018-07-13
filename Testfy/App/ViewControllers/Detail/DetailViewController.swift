//
//  DetailViewController.swift
//  Testfy
//
//  Created by Behran Kankul on 12.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

protocol DetailDisplayLogic: class
{
    func setViewModel(_ data:TweetModel)
}

class DetailViewController: BaseViewController, DetailDisplayLogic
{
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?

    // MARK: Object lifecycle
  
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var txtTweet: UITextView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblRetweetCount: UILabel!
    
    var viewModel:TweetModel? {
        didSet {
            lblUsername.text = viewModel?.user?.screenName
            lblTime.text = viewModel?.createdAt ?? ""
            txtTweet.text = viewModel?.text ?? ""
            lblLikeCount.text = "Favori: \(viewModel?.favoriteCount ?? 0)"
            lblRetweetCount.text = "Favori: \(viewModel?.retweetCount ?? 0)"
        }
    }
    var imgUrl:String? {
        didSet {
            imgUser.loadImageUsingUrlString(urlString: imgUrl!)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        DetailWorker().doSetup(self)
    
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        DetailWorker().doSetup(self)
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.updateUIWithTweet()
        self.navigationItem.title = viewModel?.user?.screenName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imgUrl = viewModel?.user!.profileImageUrl!
    }
}

extension DetailViewController {
    func setViewModel(_ data: TweetModel) {
        viewModel = data
    }
}
